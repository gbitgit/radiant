
class Admin::GroupsController < Admin::ResourceController

  active_scaffold :group
  layout "application_active_scaffold"

  active_scaffold :group do |config|

  #config.left_handed = true
#    config.create.persistent = true

#    config.actions.exclude :update
  config.actions.exclude :show
#    config.actions.exclude :delete

  #config.update.link.inline = false
  #config.create.link.inline = false
  config.list.sorting = {:id => 'DESC'}
  config.list.per_page = 22


    #config.columns[:user].form_ui = :select

  end

=begin
  paginate_models

  only_allow_access_to :index, :show, :new, :create, :edit, :update, :remove, :destroy,
    :when => [:admin],
    :denied_url => { :controller => 'admin/pages', :action => 'index' },
    :denied_message => "You must have admin privileges to manage application data_permissions."

  make_resourceful do
    actions :index, :show, :new, :create, :edit, :update, :remove, :destroy
  end

  def index
    @groups = Group.find(:all) #_as_tree
  end
  
  def new
    @group = Group.new
  end
  
  def create
    Radiant::ExtensionLoader.new()
    @group = Group.find_or_create_by_code(params[:group]['code'])
    @group.update_attributes(params[:group])
    flash[:notice] = t('permisson_extension.notices.create.success', :group => @groups.id)
    redirect_to admin_groups_url
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
#    Group.find(params[:id]).update_attribute(:value, params[:groups][:value])
#    Group.find(params[:id]).update_attributes(params[:groups])
    redirect_to admin_groups_url
  end

  def destroy
    @group = Group.find(params[:id])
    @code = @group.code
    @group.destroy
    flash[:notice] = t('groups_extension.notices.destroy.success', :group => @id)
    redirect_to admin_groups_url
  end
=end

end