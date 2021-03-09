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
  end

  scope module: 'public' do
   get root to: "homes#top"
   get "homes/about" => "homes#about"
   resources :customers, only:[:show, :edit, :update]
   resources :items, only:[:index, :show]
   resources :cart_items, only:[:index, :update, :destroy, :create]
   delete :cart_items, to: 'cart_items#destroy_all'
   resources :addresses, only:[:index, :edit, :create, :update, :destroy]
   delete 'cart_item_destroy_all' => 'cart_items#cart_item_destroy_all',as: 'cart_item_destroy_all'
  end
 end

