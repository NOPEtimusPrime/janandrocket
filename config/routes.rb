Rails.application.routes.draw do
  cms_fortress_routes :path => '/cms-admin'

  namespace :admin do
    resources :episodes
  end

  resources :episodes

  comfy_route :cms_admin, :path => '/admin'
  comfy_route :cms, :path => '/', :sitemap => false

end
