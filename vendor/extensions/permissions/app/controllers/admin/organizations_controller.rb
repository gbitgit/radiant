class Admin::OrganizationsController < Admin::ResourceController
  active_scaffold :organization
  layout "application_active_scaffold"

    active_scaffold :organization do |config|

  #config.left_handed = true
#    config.create.persistent = true

#    config.actions.exclude :update
  config.actions.exclude :show
#    config.actions.exclude :delete

  config.list.sorting = {:id => 'DESC'}
  config.list.per_page = 22


    #config.columns[:user].form_ui = :select

    end

=begin
  paginate_models

  only_allow_access_to :index, :show, :new, :create, :edit, :update, :remove, :destroy,
    :when => [:admin],
    :denied_url => { :controller => 'admin/pages', :action => 'index' },
    :denied_message => "You must have admin privileges to manage organizations for application data_permissions."

  make_resourceful do
    actions :index, :show, :new, :create, :edit, :update, :remove, :destroy
  end

  def index
    @organizations = Organization.find(:all) #_as_tree
  end
  
  def new
    @organization = Organization.new
  end
  
  def create
    Radiant::ExtensionLoader.new()
    @organization = Organization.find_or_create_by_code(params[:organization]['code'])
    @organization.update_attributes(params[:organization])
    flash[:notice] = t('permisson_extension.notices.organization.create.success', :organization => @organizations.id)
    redirect_to admin_organizations_url
  end

  def edit
    @organization = Organization.find(params[:id])
  end

  def update
#    Organization.find(params[:id]).update_attribute(:value, params[:organizations][:value])
#    Organization.find(params[:id]).update_attributes(params[:Organizations])
    redirect_to admin_organizations_url
  end

  def destroy
    @organization = Organization.find(params[:id])
    @code = @organization.code
    @organization.destroy
    flash[:notice] = t('permissions_extension.notices.organization.destroy.success', :organization => @id)
    redirect_to admin_organizations_url
  end
=end

end