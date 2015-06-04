Rails.application.routes.draw do
  namespace :admin do
    resources :episodes
  end

  resources :episodes

  comfy_route :cms_admin, :path => '/admin'
  comfy_route :cms, :path => '/', :sitemap => false

end
