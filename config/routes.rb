Rails.application.routes.draw do
  root to: 'main#index'

  match '/repositorios',
        to: 'repositories#index',
        as: 'repositories_index',
        via: [:get]

  match '/repositorios/limpar-cache',
        to: 'repositories#clear',
        as: 'repositories_clear',
        via: [:get]

  match '/repositorios/:language',
        to: 'repositories#search',
        as: 'repositories_search',
        via: [:get]
end
