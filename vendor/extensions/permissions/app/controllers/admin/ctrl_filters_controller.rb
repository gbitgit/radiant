class Admin::CtrlFiltersController < Admin::ResourceController
#  active_scaffold :ctrl_filter
  layout "application_active_scaffold"

=begin
  active_scaffold :ctrl_filter do |config|

#    config.actions = [:update]
    config.actions = [:delete,:create,:list,:show,:update,:search,:nested]
#    config.columns[:roles].ui_type = :select
#    config.left_handed = true

    config.actions.exclude :delete

    #config.update.link.inline = false
    #config.create.link.inline = false

    #config.list.sorting = [{:id => :ASC}]
    #config.list.per_page = 22


    config.label = "security_function"
    config.list.label = 'id'
    #config.columns = [:id,:code]
  end
=end



  paginate_models

  only_allow_access_to :index, :show, :new, :create, :edit, :update, :remove, :destroy,
    :when => [:admin],
    :denied_url => { :controller => 'admin/pages', :action => 'index' },
    :denied_message => "You must have admin privileges to manage security functions for application data_permissions."

  make_resourceful do
    actions :index, :show, :new, :create, :edit, :update, :remove, :destroy
  end

  def index
    @security_functions = CtrlFilter.find(:all) #_as_tree
  end
  
  def new
    @security_function = CtrlFilter.new
  end
  
  def create
    #Radiant::ExtensionLoader.new()
    @security_function = CtrlFilter.find_or_create_by_code(params[:security_function]['code'])
    @security_function.update_attributes(params[:security_function])
    flash[:notice] = t('permisson_extension.notices.security_function.create.success', :security_function => @security_functions.id)
    redirect_to admin_security_functions_url
  end

  def edit
    @security_function = CtrlFilter.find(params[:id])
  end

  def update
#    CtrlFilter.find(params[:id]).update_attribute(:value, params[:security_functionss][:value])
#    CtrlFilter.find(params[:id]).update_attributes(params[:security_functionss])
    redirect_to admin_security_functions_url
  end

  def destroy
    @security_function = CtrlFilter.find(params[:id])
    @code = @security_function.code
    @security_function.destroy
    flash[:notice] = t('permisson_extension.notices.security_function.destroy.success', :security_function => @id)
    redirect_to admin_security_functions_url
  end


end
