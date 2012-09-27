ActionController::Routing::Routes.draw do |map|
  map.namespace 'admin', :path_prefix => "admin" do |admin|
    #admin.resources :path_prefix => "admin"

    admin.resources :organizations  , :member => { :pick => :post, :inactive => :post, :remove => :get}#,:active_scaffold => true
    admin.resources :groups    , :member => { :inactive => :post, :remove => :get} #,:active_scaffold => true

    admin.resources :data_filters,  :member => { :inactive => :post, :remove => :get} #,:active_scaffold => true
    admin.resources :data_permissions,:member => { :delete => :post}#,:active_scaffold => true

    admin.resources :ctrl_filters#,:active_scaffold => true
    admin.resources :ctrl_permissions#,:active_scaffold => true

    admin.resources :categories,:member => { :pick => :post}

    admin.resources :countries, :member => { :index => :post,:show => :post}

    map.connect 'admin/countries/show/:condition/:field/:value', :controller => 'admin/countries'


admin.resources :tbl_countries, :member => { :index => :post,:show => :post}


#admin.resources :tbl_countries , :member => { :search => :get }#get 'search', :on => :collection
#admin.connect 'admin/tbl_countries/search', :controller => 'admin/tbl_countries/search', :format=>true

#resources :tbl_countries , :member => { :search => :get}


=begin
admin.resources :tbl_countries, :member => { :index => :post,:show => :post}

map.resources :countries do |country|
    country.resources :conditions do |condition|
      condition.resources :field_names  do |field|
            field.resources :values
      end
  end
=end

=begin
map.resources :publishers do |publisher|
  publisher.resources :magazines do |magazine|
    magazine.resources :photos
  end
end
However, without the use of name_prefix => nil, deeply-nested resources quickly become cumbersome.
In this case, for example, the application would recognize URLs such as

/publishers/1/magazines/2/photos/3
=end

  end
end

