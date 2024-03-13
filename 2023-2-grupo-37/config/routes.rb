Rails.application.routes.draw do
  get 'users/show'
  get 'rooms/index'
  root 'pagina_principal#index'
  # PAGINAS PRINCIPALES (cuenta, inicio, etc.)
  get 'pagina_principal/index'
  get '/cuenta', to: 'pagina_principal#cuenta'
  get '/inicio', to: 'pagina_principal#index'

  # Usuarios
  devise_scope :user do
    get 'users', to: 'devise/sessions#new'
  end
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }, 
                   path: '', path_names: {sign_in: 'login', sign_out: 'logout', sign_up: 'register'}
  get 'user/:id', to: 'users#show', as: 'user'

  # Chat
  resources :rooms do
    resources :messages
  end

  resources :pins

  get 'hello_world/index'

  # PRODUCTOS 
  get 'productos', to: 'productos#index'
  get '/productos/new', to: 'productos#new'
  get 'productos/:id', to: 'productos#show', as: 'producto'
  get 'productos/:id/eliminar', to: 'productos#destroy', as: 'eliminar_producto'
  get 'productos/:id/editar', to: 'productos#page_update', as: 'editar_producto'
  get 'productos/:id/favorito', to: 'productos#favoritos', as: 'favoritos_usuario'
  patch 'productos/:id', to: 'productos#update', as: 'update_producto'
  post 'productos', to: 'productos#create'
  get 'producto/populares', to: "productos#mas_visitados", as: "mas_visitados"

  # INTERCAMBIOS
  get 'intercambios', to: 'intercambios#index'
  get 'intercambios/:id/create', to: 'intercambios#create', as: 'crear_intercambio'
  get 'intercambios/:id/eliminar', to: 'intercambios#destroy', as: 'eliminar_intercambio'
  get 'intercambios/:id/editar', to: 'intercambios#page_update', as: 'editar_intercambio'
  patch 'intercambios/:id', to: 'intercambios#update', as: 'update_intercambio'
  post 'intercambios/:id', to: 'intercambios#create', as: 'postear_intercambio'

  # REPORTES
  get "reportes/:id/new", to: "reportes#new", as: "nuevo_reporte"
  get "reportes/:id", to: "reportes#show", as: "ver_reportes"
  post "reportes/:id", to: "reportes#create", as: "crear_reporte"
  get "reporte/:id/editar", to: "reportes#page_update", as: "editar_reporte"
  patch "reporte/:id", to: "reportes#update", as: "actualizar_reporte"
  get "reporte/:id/eliminar", to: "reportes#destroy", as: "eliminar_reporte" 

  # ADMINISTRADOR
  get '/admin', to: 'admins#index'
  get '/admin/productos', to: 'admins#productos'
  get '/admin/reportes', to: 'admins#reportes'
  get '/admin/intercambios', to: 'admins#intercambios'
  get '/admin/usuarios', to: 'admins#usuarios'
  
  # USUARIOS
  get "usuarios/:id/editar", to: "users#page_update", as: "editar_usuario"
  get "usuario/:id", to: "users#cuenta_visita", as: "ver_usuario"
  post "usuario/:id", to: "users#calificar_usuario", as: "calificar_usuario"
  patch "usuarios/:id", to: "users#update", as: "actualizar_usario"
  get "usuarios/:id/eliminar", to: "users#destroy", as: "eliminar_usuario"
  get "usuario/:id/favoritos",  to: "users#favoritos", as: "mostrar_favoritos"
  get "usuario/:id/eliminar_favorito", to: "productos#eliminar_favorito", as: "eliminar_favorito"
end
