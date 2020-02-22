'use strict';

const Joi = require('@hapi/joi');
const cloudinary = require('cloudinary').v2;
const mysqlPool = require('../../../database/mysql-pool');
const uuidV4 = require('uuid/v4');

cloudinary.config({
  cloud_name: process.env.CLOUDINARY_CLOUD_NAME,
  api_key: process.env.CLOUDINARY_API_KEY,
  api_secret: process.env.CLOUDINARY_API_SECRET
});

async function validate(data) {
  const schema = Joi.object({
    title: Joi.string()
      .trim()
      .min(1)
      .max(60)
      .required(),
    subtitle: Joi.string()
      .trim()
      .min(1)
      .max(135)
      .required(),
    category: Joi.string().required(),
    ubication: Joi.string()
      .max(60)
      .required(),
    image_url: Joi.object(),
    video_url: Joi.string().max(512),
    prize: Joi.number(),
    duration: Joi.number(),
    text: Joi.string()
      .max(65536)
      .required(),
    rewards: Joi.array().items(
      Joi.object({
        prize: Joi.number(),
        title: Joi.string().max(60),
        month: Joi.string().max(20),
        year: Joi.number(),
        subtitle: Joi.string().max(135)
      })
    ),
    userId: Joi.string()
      .guid({
        version: ['uuidv4']
      })
      .required()
  });

  Joi.assert(data, schema);
}

async function createProject(req, res, next) {
  const { projectData } = req.body;
  const { userId } = req.claims;

  try {
    const data = {
      ...projectData,
      userId
    };
    await validate(data);
  } catch (e) {
    console.error(e);
    return res.status(400).send(e);
  }

  const { file } = req;

  if (!file || !file.buffer) {
    return res.status(400).send({
      message: 'invalid image'
    });
  }

  const createdAt = new Date()
    .toISOString()
    .substring(0, 19)
    .replace('T', ' ');
  const projectId = uuidV4();
  const capitalize = (s) => {
    if (typeof s !== 'string') return '';
    return s.charAt(0).toUpperCase() + s.slice(1);
  };

  cloudinary.uploader
    .upload_stream(
      {
        resource_type: 'image',
        public_id: projectId,
        width: 200,
        height: 200,
        format: 'jpg',
        crop: 'limit'
      },
      async (err, result) => {
        if (err) {
          console.error(err);
          return res.status(400).send(err);
        }

        const { secure_url: secureUrl } = result;

        let connection;
        try {
          connection = await mysqlPool.getConnection();
          await connection.query('INSERT INTO project SET ?', {
            id: projectId,
            title: capitalize(projectData.title),
            subtitle: capitalize(projectData.subtitle),
            category: projectData.category,
            ubication: projectData.ubication,
            image_url: projectData.image_url,
            video_url: projectData.video_url,
            prize: projectData.prize,
            duration: projectData.duration,
            text: capitalize(projectData.text),
            created_at: createdAt,
            user_id: userId
          });
          connection.execute(secureUrl, projectId);

          res.header('Location', secureUrl);
          return res.status(201).send();
        } catch (e) {
          if (connection) {
            connection.release();
          }
          console.error(e);
          return res.status(500).send(e.message);
        }
      }
    )
    .end(file.buffer);
}

module.exports = createProject;
