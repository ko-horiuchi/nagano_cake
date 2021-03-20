Rails.application.routes.draw do
  devise_for :customers, controllers: {
   registrations: 'customers/registrations',
   sessions: 'customers/sessions'
  }

  devise_for :admins, path: 'admin', controllers: {
   sessions: 'admins/sessions'
  }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :admin do
   get root to: "homes#top"
   resources :items, except:[:destroy]
   resources :genres, only:[:index, :create, :edit, :update]
   resources :customers, only:[:index, :show, :edit, :update]
   resources :orders, only:[:show, :update]
   resources :orders_details, only:[:update]
  end

 scope module: 'public' do
   get root to: "homes#top"
   get "homes/about" => "homes#about"
   resources :customers, only:[:edit, :update]
   get 'customers/my_page' => 'customers#show', as: 'customers/my_page'
   get 'customers/unsubscribe' => 'customers#unsubscribe', as: 'customers/unsubscribe'
   patch ':id/withdraw/' => 'customers#withdraw', as: 'customers/withdraw'
   put 'customers/withdraw' => 'customers#withdraw'
   resources :items, only:[:index, :show]
   resources :cart_items, only:[:index, :update, :destroy, :create]
   delete :cart_items, to: 'cart_items#destroy_all'
   resources :addresses, only:[:index, :edit, :create, :update, :destroy]
   delete 'cart_item_destroy_all' => 'cart_items#cart_item_destroy_all',as: 'cart_item_destroy_all'
   resources :orders, only:[:index, :create, :new]
   get ':id/orders' => 'orders#show', as: 'order_show'
   get 'orders/complete' => 'orders#complete', as: 'orders/complete'
   post 'orders/confirm' => 'orders#confirm', as: 'orders/confirm'
  end
 end
 
