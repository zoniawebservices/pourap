Rails.application.routes.draw do



  resources :banners, except: [:show]
  mount Ckeditor::Engine => '/ckeditor'
  resources :events
  devise_for :bloggers
  resources :projects
  resources :abouts
  resources :bloggers
  resources :videos
  resources :homes
  resources :musics do
    resources :musiccomments
  end
  end
  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
