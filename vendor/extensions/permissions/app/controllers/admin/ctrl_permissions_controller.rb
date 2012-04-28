#class Admin::PermissionsController < ApplicationController
class Admin::CtrlPermissionsController < Admin::ResourceController

  active_scaffold :ctrl_permission
  layout "application_active_scaffold"

  active_scaffold :ctrl_permission do |config|

  #config.left_handed = true
#    config.create.persistent = true

#    config.actions.exclude :update
  config.actions.exclude :show
#    config.actions.exclude :delete

  #config.update.link.inline = false
  #config.create.link.inline = false
  config.list.sorting = {:id => 'DESC'}
  config.list.per_page = 22

    config.columns[:ctrl_filter].form_ui = :select
    config.columns[:group].form_ui = :select
    config.columns[:organization].form_ui = :select

  end


=begin
  paginate_models

  only_allow_access_to :index, :show, :new, :create, :edit, :update, :remove, :destroy,
#    :when => (Permission['roles.data_permissions'].split(',').collect{|s| s.strip.underscore }.map(&:to_sym) rescue :admin || :admin),
    :denied_url => { :controller => 'admin/pages', :action => 'index' },
    :denied_message => "You must have admin privileges to manage controller data_permissions for application data_permissions."
  
  def index
    @ctrl_permissions = CtrlPermission.find(:all) #_as_tree
  end
  
  def new
    @ctrl_permission = CtrlPermission.new
  end
  
  def create
    @ctrl_permission = CtrlPermission.find_or_create_by_code(params[:ctrl_permission]['code'])
    @ctrl_permission.update_attributes(params[:ctrl_permission])
    flash[:notice] = t('permisson_extension.notices.ctrl_permissions.create.success', :ctrl_permission => @ctrl_permissions.code)
    redirect_to admin_ctrl_permissions_url
  end

  def edit
    @ctrl_permission = CtrlPermission.find(params[:id])
  end

  def update
#    Permission.find(params[:id]).update_attribute(:value, params[:permission][:value])
    CtrlPermission.find(params[:id]).update_attribute(:code, params[:ctrl_permission][:code])
    redirect_to admin_ctrl_permissions_url
  end

  def destroy
    @ctrl_permission = CtrlPermission.find(params[:id])
    @code = @ctrl_permission.code
    @ctrl_permission.destroy
    flash[:notice] = t('permissions_extension.notices.ctrl_permissions.destroy.success', :ctrl_permission => @code)
    redirect_to admin_ctrl_permissions_url
  end
  # END tree editor
=end

end

=begin

    active_scaffold :permission do |config|

    #config.left_handed = true
#    config.create.persistent = true

#    config.actions.exclude :update
    config.actions.exclude :show
#    config.actions.exclude :delete

    #config.update.link.inline = false
    #config.create.link.inline = false
    config.list.sorting = {:id => 'DESC'}
    config.list.per_page = 22


      has_columns [
      [:id => {
        :description => :id
        #:exclude => [:create, :update, :create_at, :update_at, :created_at, :updated_at, :create_in, :update_in]
      }],
      [:code => {
        :description => :name_description,
        #:inplace_edit => true,
        :options => {:print_width => '140'},
        :required => false
      }],
      ]


    end



  active_scaffold :www_place_user do |config|

    config.left_handed = true
#    config.create.persistent = true

#    config.actions.exclude :update
    config.actions.exclude :show
#    config.actions.exclude :delete

    #config.update.link.inline = false
    #config.create.link.inline = false
    config.list.sorting = {:id => 'DESC'}
    config.list.per_page = 22

    config.actions.add :live_search
    config.actions.swap :search, :field_search
    config.actions << :customize
    config.actions << :print_list
    config.actions << :export_tool

#config.nested.add_link 'WwwPlace' , [:WwwPlace]
#config.nested.add_link 'Info' , [:WwwPlace]

config.action_links.add 'loginAcc', :parameters => {:table_name => model.table_name },
           :label => 'Login', :type => :record, :page => true
config.action_links.add 'loginInbox3WPlaceUsers', :label => 'Inbox', :type => :record, :page => true

#    config.actions << :live_search
#config.columns[:www_place].search_sql = 'www_places.sh_name'
#config.columns[:tbl_user].search_sql = 'tbl_users.login'
#config.live_search.columns = [:id, :www_place, :tbl_user]

#
#  config.actions.exclude :search
#  config.actions << :advanced_search
#  config.advanced_search.columns = [:id, :www_place, :tbl_user, :login]


      has_columns [
      [:id => {
        :exclude => [:create, :update, :create_at, :update_at, :created_at, :updated_at, :create_in, :update_in]
      }],
      [:www_place => {
        :description => :name_description,
        :inplace_edit => true,
          :options => {:print_width => '140'},
          :required => false
      }],
=end
