ActionController::Routing::Routes.draw do |map|
  map.namespace 'admin', :path_prefix => "admin" do |admin|
    #admin.resources :path_prefix => "admin"

    admin.resources :organizations  , :member => { :pick => :post, :inactive => :post, :remove => :get}, :active_scaffold => true
    admin.resources :groups    , :member => { :inactive => :post, :remove => :get} , :active_scaffold => true

    admin.resources :data_filters,  :member => { :inactive => :post, :remove => :get} , :active_scaffold => true
    admin.resources :data_permissions,:member => { :delete => :post}, :active_scaffold => true

    admin.resources :ctrl_filters, :active_scaffold => true
    admin.resources :ctrl_permissions, :active_scaffold => true

    admin.resources :categories,    :member => { :pick => :post}
  end
end

