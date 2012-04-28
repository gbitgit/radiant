ActionController::Routing::Routes.draw do |map|
  map.dashboard 'admin/dashboard/:action', :controller => 'admin/dashboard'
    map.namespace 'admin' do |admin|
    admin.resources :dashboard
    end
end