Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get "/directors", to: "director#index"
  post "/directors", to: "director#create"
  get "/director/:id", to: "director#show"
  delete "/director/:id", to: "director#destroy"
  delete "/directors", to: "director#destroy_todos"
  get "/directors/oscars", to: "director#show_oscars"

  get "/director/:director_id/movies", to: "movies#movies_por_director"
  post "/director/:director_id/movies", to: "movies#create"
  patch "/director/:director_id/movies/:movie_id", to: "movies#update"
  get "/movies/sinopsis/:keyword", to: "movies#buscar_por_keyword"

  post "/ranking/:director_id", to: "rankings#create"
  get "/ranking/:director_id", to: "rankings#rankings_por_director"
  get "/ranking/top/:quantity", to: "rankings#mejores_rankings"
  get "/movies/:movie_id/director/rankings", to: "rankings#encontrar_rankings"
  delete "/director/ranking/low", to: "rankings#eliminar_peor_director"
  get "/ranking/pages/all", to: "rankings#paginas_rankings"
end
