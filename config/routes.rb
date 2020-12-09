Rails.application.routes.draw do

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: %w[show]
    end
  end

  devise_for :users,
             defaults: { format: :json },
             path: '',
             path_names: {
               sign_in: 'api/v1/login',
               sign_out: 'api/v1/logout',
               registration: 'api/v1/signup'
             },
             controllers: {
               sessions: 'api/v1/sessions',
               registrations: 'api/v1/registrations'
             }
end
