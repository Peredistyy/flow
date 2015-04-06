Rails.application.routes.draw do
  devise_for :users,
             controllers: {
                 registrations: 'users/registrations',
                 sessions: 'users/sessions',
                 omniauth_callbacks: 'users/omniauth_callbacks'
             }

  root to: 'welcome#index'

  get 'lists', to: 'lists#index'

  resources :projects
  resources :tasks
  post 'tasks/resorted', to: 'tasks#resorted'
  resources :comments
end
