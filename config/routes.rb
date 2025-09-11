Rails.application.routes.draw do
  get "blogs/index"
  devise_for :users, controllers: { registrations: 'users/registrations' }
  get 'users' =>'users#index'
  get 'posts/music' => 'posts#music'
  get 'posts/video' => 'posts#video'
  get "mypage", to: "users#show", as: :mypage


  resources :users, only: [:show] do
  member do
    get :comments_list
  end
end
 # ユーザーマイページへのルーティング

  root to: 'tweets#index'
  resources :blogs
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :tweets do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:index, :create]
    get :comments_list, on: :member
  end

end