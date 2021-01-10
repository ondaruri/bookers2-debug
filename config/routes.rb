Rails.application.routes.draw do
  get 'serch/serch'
  devise_for :users
  root to: 'homes#top'
  resources :users,only: [:show,:index,:edit,:update] do
    member do
      get :follows, :follower
    end
  end

  resources :books do
    resource :post_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  get 'home/about' => 'homes#about'
  post 'follow/:id' => 'relationships#follow', as: 'follow' #フォローする
  post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow' #フォロー外す

  get '/search' => 'search#search'

#   Railsのルーティングは、ルーティングファイルの上からの記載順に読み込まれていきます。
# 現在、resources :users,only: [:show,:index,:edit,:update]が上にあるため、
# GET '/users/:id' => 'users#show'
# というルーティングが決まってしまいます。
# deviseのサインインのルーティングは、
# GET '/users/sign_in'
# ですが、「idがsign_in」という判定になり、users#showが呼び出されてしまいます。
# usersコントローラにはログイン制限がかかっているので、
# '/users/sign_in' => users#show
# => ログインしていないので、'/users/sign_in'にリダイレクト => users#show
# => ...
# という無限ループになってしまう状態です。
# devise_forを上にしてあげることで、
# GET '/users/sign_in' => 'devise/sessions#new'というルーティングが先に決まるため、
# users#showは呼び出されなくなります。
end