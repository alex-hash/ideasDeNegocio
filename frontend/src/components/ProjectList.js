import React from 'react';
import Navbar from '../components/Navbar';
import { Link } from 'react-router-dom';
import { useAuth } from '../context/auth-context';

export function ProjectList({ projects, searchText, onSearchTextChanged }) {
  const { role } = useAuth();

  function displayButtonCreate(role) {
    if (role === 'E') {
      return (
        <a
          href="/create-project"
          className="mt-4 md:mt-0 bg-button text-white font-bold p-4 rounded focus:outline-none focus:shadow-outline"
        >
          Crear proyecto
        </a>
      );
    }
  }

  return (
    <div className="min-h-screen">
      <div>
        <Navbar role={role} />
      </div>
      <div className="mt-16 flex flex-wrap justify-around md:justify-between px-4 sm:mx-12">
        <input
          type="search"
          value={searchText}
          class="w-full md:w-1/2 shadow appearance-none border rounded p-4 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
          placeholder="Busca por nombre,categoría..."
          onChange={(e) => onSearchTextChanged(e.target.value)}
        />
        {displayButtonCreate(role.role)}
      </div>
      <div class="mt-16">
        <div class="px-4 sm:mx-10">
          <div class="block md:flex flex-wrap justify-left">
            {projects.map((project) => (
              <div class="w-full md:w-1/2 md:px-2 lg:w-1/3 mb-4" key={project.id}>
                <div class="bg-white rounded-lg overflow-hidden shadow">
                  <a href={'/project/' + project.id}>
                    <img
                      class="h-48 w-full object-cover object-center"
                      src={project.image_url}
                      alt="Foto de Proyecto"
                    />
                  </a>
                  <div class="p-4 h-auto md:h-48 mt-2">
                    <a href={'/project/' + project.id} className="text-gray-800 font-bold text-xl mb-2">
                      {project.title}
                    </a>
                    <div class="text-gray-600 text-sm leading-relaxed block md:text-xs lg:text-sm">
                      {project.subtitle}
                    </div>
                    <p class="text-gray-600 text-sm leading-relaxed block md:text-xs lg:text-sm">{project.category}</p>
                    <p class="text-sm leading-relaxed font-semibold block md:text-xs lg:text-sm">Valoración media: {project.avg === null ? "Sin valoración todavía" : Math.round(project.avg * 100) / 100 + " / " + project.counter + " opiniones"}</p>
                    <div className="flex items-center">
                      <Link
                        to={'/user/' + project.user}
                        className="mt-6 block h-12 w-12 rounded-full overflow-hidden border-2 border-gray-600 focus:outline-none focus:border-white"
                      >
                        <img className="h-full w-full object-cover" src={project.avatar_url} alt="Your avatar" />
                      </Link>
                      <div className="text-sm ml-4 pt-6">
                        <p className="text-gray-900 leading-none">{project.name + ' ' + project.first_name}</p>
                        <p className="text-gray-600">
                          {project.updated_at === null
                            ? project.created_at.replace('T', ' ').substring(0, 16)
                            : project.updated_at.replace('T', ' ').substring(0, 16)}
                        </p>
                      </div>
                      <div class="mt-2 lg:absolute bottom-0 mb-4 md:hidden lg:block"></div>
                    </div>
                  </div>
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>
    </div>
  );
}
