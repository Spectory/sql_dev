SqlDev::Application.routes.draw do
  root 'static_pages#home'
  get 'static_pages/home'

  get '/robots.txt', to: 'application#robots'
end
