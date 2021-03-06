Rails.application.routes.draw do
  devise_for :users ,controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
    authenticated :user do
      root 'playlist_cleaners#index'
    end

    unauthenticated do
      root 'devise/sessions#new'
    end
  end
  resources :playlist_cleaners, only: %w[index show create] do
    resources :tracks, only: :show do
      member do
        post 'vote_move'
        post 'vote_delete'
        post 'save_to_library'
      end
    end
  end
  # Sidekiq Web UI, only for admins.
  require "sidekiq/web"
  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end
end
