#class Admin::PermissionsController < ApplicationController
class Admin::DataPermissionsController < Admin::ResourceController

  helper '/admin/data_permissions'

=begin
  active_scaffold :data_permission
  layout "application_active_scaffold"

  helper '/admin/data_permissions'

  active_scaffold :data_permission do |config|

#    config.left_handed = true
#    config.create.persistent = true

#    config.actions.exclude :update
    config.actions.exclude :show
#    config.actions.exclude :delete

  #config.update.link.inline = false
  #config.create.link.inline = false
    config.list.sorting = {:id => 'DESC'}
    config.list.per_page = 22
    #config.actions = [:list, :nested, :edit]

    config.actions.add :live_search
    config.list.empty_field_text = 'not filled'

    #config.create.empty_field_text = 'fill it'
    #config.update.empty_field_text = 'fill it'

#    config.columns[:crud_c].form_ui = :checkbox
#    update.columns[:crud_c].form_ui = :checkbox

#    config.columns[:data_filter].form_ui = :select
#    config.columns[:group].form_ui = :select
#    config.columns[:organization].form_ui = :select

#    config.columns[:organization].includes = [:organization]
#    config.columns[:group].includes = [:group]
#    config.columns[:data_filter].includes = [:data_filter]

    config.live_search.columns = [:code, :desc]
    config.live_search.text_search = :full

    config.columns[:code].search_sql = 'list.code'

    #config.columns[:data_filter].options = {:draggable_lists => true}
    #config.nested.add_link("Company's contacts", [:data_filter])

    config.columns = [:id,:crud_c,:code,:desc]#,:data_filter,:group,:organization,:created_at,:children,:parent]
    #create.columns.exclude :id
    #update.columns.exclude :id

#update.columns.add :bit_crud

#    config.columns[:organization].associated_number = false
#    config.columns[:group].associated_number = false
#    config.columns[:data_filter].associated_number = false

    #config.columns[:crud_c].form_ui = :checkbox‎

#    config.columns[:crud_c].options =  {:width => "10px"}
#    config.columns[:crud_r].options =  {:width => "15x"}
#    config.columns[:crud_u].options =  {:screen_width => "10px"}
#    config.columns[:crud_d].options =  {:screen_width => "10px"}
#
#    config.columns[:crud_c].description = "(Format: +|-)"
#    config.columns[:crud_c].label = "CREATE"
#
#    config.columns[:crud_r].description = "(Format: +|-)"
#    config.columns[:crud_r].label = "READ"


#    conf.action_links.member.add 'fire', :confirm => 'are_you_sure', :type => :member, :method => :put, :position => false,
#                             :ignore_method => :ignore_fire_action?, :parameters => {:static => 'static'}

#    conf.action_links.add 'fire', :confirm => 'are_you_sure', :type => :member, :method => :put, :position => false,
#                          :ignore_method => :ignore_fire_action?, :parameters => {:static => 'static'}, :dynamic_parameters => Proc.new {{:dynamic => random_number}}


    #config.columns[:organization].inplace_edit = true
    #config.columns=[:id,:group_present,:data_filter,:group,:organization]

    #config.columns[:bit_crud].form_ui = :checkbox
    #config.columns[:bit_crud_c].options[:options] = [["val1",(1 == 1)],["val2",(0 == 1)],["val3",(0 == 1)],["val4",(0 == 1)]]

#config.columns[:bit_crud].form_ui = :checkbox
#config.columns[:bit_crud].options[:options] = ['Male', '1', 'Female','2']

  end
=end

  paginate_models

  only_allow_access_to :show, :new, :create, :edit, :update, :remove, :destroy,  #:index,
#    :when => (Permission['roles.data_permissions'].split(',').collect{|s| s.strip.underscore }.map(&:to_sym) rescue :admin || :admin),
    :denied_url => { :controller => 'admin/pages', :action => 'index' },
    :denied_message => "You must have admin privileges to manage application data_permissions."


  def index
    @data_permissions = DataPermissionsHelper.find(:all) #_as_tree
    list
  end
  
  def new
    logger.warn "#{Time.now.strftime("%H:%M:%S:%3N")} new '#{params[:data_permission]}'"
    @data_permission = DataPermissionsHelper.new
    logger.warn "#{Time.now.strftime("%H:%M:%S:%3N")} new @data_permission='#{@data_permission}'"
    #create
    render :partial => "create_form", :object => @data_permission
  end
  
  def create
    logger.warn "#{Time.now.strftime("%H:%M:%S:%3N")} caller='#{params[:data_permission]}'"

    @data_permission = DataPermissionsHelper.find_or_create_by_code(params[:data_permission])
    @data_permission.update_attributes(params[:data_permission])
    flash[:notice] = t('permisson_extension.notices.create.success', :data_permission => @data_permissions.code)
    redirect_to admin_data_permissions_url
  end

  def edit
    @data_permission = DataPermissionsHelper.find(params[:id])
  end

  def update
#    Permission.find(params[:id]).update_attribute(:value, params[:permission][:value])
    DataPermissionsHelper.find(params[:id]).update_attribute(:code, params[:data_permission][:code])
    redirect_to admin_data_permissions_url
  end

  def destroy
    @data_permission = DataPermissionsHelper.find(params[:id])
    @code = @data_permission.code
    @data_permission.destroy
    flash[:notice] = t('permissions_extension.notices.destroy.success', :data_permission => @code)
    redirect_to admin_data_permissions_url
  end
  # END tree editor



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
