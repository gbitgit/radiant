class Admin::DataFiltersController < Admin::ResourceController
  active_scaffold :data_filter
#    render :partial => "page_field", :object => model,
#      :locals => { :page_field_counter => params[:page_field_counter].to_i}
  layout "application_active_scaffold"
  active_scaffold :data_filter do |config|


    config.list.sorting = [{:id => :ASC}]
    config.list.per_page = 22


  end

=begin
  paginate_models


  only_allow_access_to :index, :show, :new, :create, :edit, :update, :remove, :destroy,
    :when => [:admin],
    :denied_url => { :controller => 'admin/pages', :action => 'index' },
    :denied_message => "You must have admin privileges to manage data filters."

  make_resourceful do
    actions :index, :show, :new, :create, :edit, :update, :remove, :destroy
  end

  def index
    @data_filters = DataFilter.find(:all) #_as_tree
    list
  end
  
  def new
    @data_filter = DataFilter.new
    #render :action=>:create
    render :partial => "create_form", :object => @data_filter
  end
  
  def create
    #Radiant::ExtensionLoader.new()
    @data_filter = DataFilter.find_or_create_by_code(params[:data_filter]['code'])
    @data_filter.update_attributes(params[:data_filter])
    flash[:notice] = t('permisson_extension.notices.create.success', :data_filter => @data_filters.id)
    redirect_to admin_data_filters_url
  end

  def edit
    @data_filter = DataFilter.find(params[:id])
    render  update_form
  end

  def update
#    DataFilter.find(params[:id]).update_attribute(:value, params[:data_filters][:value])
#    DataFilter.find(params[:id]).update_attributes(params[:data_filters])
    redirect_to admin_data_filters_url
  end

  def destroy
    @data_filter = DataFilter.find(params[:id])
    @code = @data_filter.code
    @data_filter.destroy
    flash[:notice] = t('data_filters_extension.notices.destroy.success', :data_filter => @id)
    redirect_to admin_data_filters_url
  end
=end





#  def public_perfect_functions_method
#    @what='aga'
#    redirect_to admin_data_filters_url
#  end

#  def public_another_perfect_functions_method
#    @what='aga2'
#  end

#private
#  def secret_method
#    @secret='here'
#  end
end