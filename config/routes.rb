Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  resources :users,only: [:show,:index,:edit,:update]
  resources :books do
    resources :post_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  get 'home/about' => 'homes#about'
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