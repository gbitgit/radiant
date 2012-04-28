require 'find'


#Since Rails doesn't load classes unless it needs them, you must read the models from the folder. Here is the code

    controller_directory = "#{RAILS_ROOT}/app/models/"
    ext_controller_directory = "#{RAILS_ROOT}/vendor/extensions/"
    controller_files = []
    controllers_and_actions = []
    Find.find(controller_directory) do |node|
      next unless (node.match(/app\/models/) and node.match(/.rb$/))
      if FileTest.file?(node)
        #controller_files << node.gsub("#{controller_directory}","")
#puts node#.gsub("controllers","models").gsub(/s?_controller/,"")
  begin
    require node#.gsub("controllers","models").gsub(/s?_controller/,"")
  rescue
  end
      end
    end
    Find.find(ext_controller_directory) do |node|
      next unless (node.match(/app\/models/) and node.match(/.rb$/))
      if FileTest.file?(node)
        #controller_files << node.gsub("#{ext_controller_directory}","") if node.match(/.*_controller.rb/)
puts node#.gsub("controllers","models").gsub(/s?_controller/,"")
  begin
    require node#.gsub("controllers","models").gsub(/s?_controller/,"")
  rescue
  end
  end
  end


=begin
puts "*******************************"
puts "List of controller_actions"
puts "*******************************"


controller_actions = ActionController::Routing::Routes.routes.inject({}) do |controller_actions, route|
      (controller_actions[route.requirements[:controller]] ||= []) << route.requirements[:action]
controller_actions
end

controller_actions.each do |c|
  puts "Controller: #{c[0]}\n"
  puts "Actions: #{c[1]}\n\n"
#  puts "Actions: #{eval("#{c[0].camelize.gsub('/','')}.new.action_methods").collect{|a| a.to_s}.join(', ')}\n\n"
end

# returns 'Actions: ["admin/configuration", ["new", "edit", "show", "update", "destroy", "create"]]'
=end


puts "*******************************"
puts "List of controller_actions"
puts "*******************************"

controllers_and_actions=[{}]

#class PopulateRights < ActiveRecord::Migration
#  def self.up
    controller_directory = "#{RAILS_ROOT}/app/controllers/"
    ext_controller_directory = "#{RAILS_ROOT}/vendor/extensions/"
    controller_files = []
    controllers_and_actions = []
    Find.find(controller_directory) do |node|
      next unless (node.match(/app\/controllers/) and node.match(/.rb$/))
      if FileTest.file?(node)
	#puts node.gsub("#{controller_directory}","")
        controller_files << node.gsub("#{controller_directory}","")
      end
    end
    Find.find(ext_controller_directory) do |node|
      next unless (node.match(/app\/controllers/) and node.match(/.rb$/))
      if FileTest.file?(node)
        controller_files << node if node.match(/.*_controller.rb/)
	puts node.gsub("#{ext_controller_directory}","")
      end
    end

    controller_files.each do |controller_file|
      if controller_file =~ /_controller/
        puts "controller_file = #{controller_file}"
        controller_path = controller_file.gsub(/_controller.rb/,"")
        controller = controller_file.gsub("#{ext_controller_directory}","").camelize.gsub(".rb","").gsub("/","::").gsub(/.*::App::Controllers::/,'') 
	puts controller
#	controller = 'Admin::'+controller if !controller.match(/Admin::/) and controller_file.match(/app\/controllers\/admin/)
        actions = []	
        (eval("#{controller}.new.methods") - (ApplicationController.methods + Object.methods + ApplicationController.new.methods - ["new"])).sort.each do |action|
          actions << action.to_s.gsub("--- :",'')#.gsub("_",'')
        end
puts "************  #{controller} ************"
#puts actions
        controllers_and_actions << { :controller => controller.gsub("::",'').gsub(/Controller/,''), :actions => actions.collect{|a| a.to_s} }
      end
    end

puts "*******************************"
puts "*******************************"
puts "END of List of controller_actions"
puts "*******************************"
puts "*******************************"

puts "BEGIN of add new security functions records AKA Rails controllers & methods"

CtrlFilter.transaction do 
admin=User.find_by_login('admin')
admin_groups=Group.find(:all,:conditions => [ "code = ? or code = ? ",'root','admins'],:select => "id").collect!{|a| a.id}

#insert CtrlPermission controller's nodes first
controllers_and_actions.each do |controller_actions|
				attributes=
				{
				  :code =>(controller_actions[:controller].to_s+'').upcase,
				  :desc =>(controller_actions[:controller].to_s+''),
				  :controller =>controller_actions[:controller],
				  :method =>controller_actions[:controller],
				  :created_by =>admin[:id],
				  :updated_by =>admin[:id],
				}
	ctrl_filter = CtrlFilter.new
	ctrl_filter.update_attributes(attributes)
	ctrl_filter.save
end

controllers_and_actions.each do |controller_actions|
      controller_actions[:actions].each do |action|
        #Right.create(:name => action.titlecase + ' ' + controller_actions[:controller].titlecase, :controller => controller_actions[:controller], :action => action)
CtrlFilters=CtrlFilter.find(:first, :conditions => [ "controller = ? and method = ?",controller_actions[:controller],action])
CtrlFilter_node=CtrlFilter.find(:first, :conditions => [ "controller = ? and controller = method",controller_actions[:controller]])
		if CtrlFilters.nil? 
			attributes=
			{
			  :code =>(controller_actions[:controller].to_s+'_'+action.to_s).upcase,
			  :desc =>(controller_actions[:controller].to_s+'_'+action.to_s),
			  :controller =>controller_actions[:controller],
			  :method =>action,
			  :created_by =>admin[:id],
			  :updated_by =>admin[:id],
			  :parent_id=>CtrlFilter_node[:id],
			}

			ctrl_filter = CtrlFilter.new
			ctrl_filter.update_attributes(attributes)
			ctrl_filter.save
		end
   end
end
end

puts "END of add new controller methods"

puts "BEGIN of add new Control Permissions records AKA link from user group to Rails controllers & methods"

CtrlPermission.transaction do 
admin=User.find_by_login('admin')
groups=Group.find(:all)
orgs=Organization.find(:all)
admin_groups=Group.find(:all,:conditions => [ "code = ? or code = ? ",'root','admins'],:select => "id").collect!{|a| a.id}

ctrl_filters=CtrlFilter.find(:all,:conditions=>[ "controller = method "])

#insert CtrlPermission controller's nodes first
ctrl_filters.each do |ctrl_filter|
crud_flag='-'
crud_flag='c' if ctrl_filter[:method].downcase =~ /new|create/
crud_flag='r' if ctrl_filter[:method].downcase =~ /index|list|show|find|search/
crud_flag='u' if ctrl_filter[:method].downcase =~ /edit|update/
crud_flag='d' if ctrl_filter[:method].downcase =~ /delete|destroy|remove/
groups.each do |group|
orgs.each do |org|

				attributes=
				{
				  :code =>(ctrl_filter[:controller]+(ctrl_filter[:controller]==ctrl_filter[:method] ? '' : ('::'+ctrl_filter[:method]))).upcase,
				  :desc =>(ctrl_filter[:controller]+(ctrl_filter[:controller]==ctrl_filter[:method] ? '' : ('::'+ctrl_filter[:method]))),
				  :organization_id =>org[:id],
				  :group_id =>group[:id],
				  :ctrl_filter_id =>ctrl_filter[:id],
				  :created_by =>admin[:id],
				  :updated_by =>admin[:id],
				}
				if admin_groups.include?(group[:id])
					attributes.merge(
						{
							:can_create=>'+',
							:can_read=>'+',
							:can_update=>'+',
							:can_destroy=>'+',
						}
					)
				end
				
				if !ctrl_filter[:controller]==ctrl_filter[:method] and !crud_flag=='-'
					attributes.merge(
						{
				  			:crud_flag=>crud_flag,
						}
					)
				end
	ctrl_permission = CtrlPermission.new
	ctrl_permission.update_attributes(attributes)
	ctrl_permission.save
end
end
end
end
puts "END of add new controller methods"

puts "Remove old controller methods"

CtrlFilter.transaction do 
	CtrlFilters=CtrlFilter.find(:all,:select => "DISTINCT id,controller,method",:conditions => [ "(controller = method)"])
	CtrlFilters_db= CtrlFilters.collect{|a| [a.controller,a.method]}
	CtrlFilters_remove=CtrlFilters_db.dup

	CtrlPermissions_db=CtrlPermission.find(:all,:select => "DISTINCT id,ctrl_filter_id").collect{|a| [a.ctrl_filter_id,a.id]}
	CtrlPermissions_remove=CtrlPermissions_db.dup

#puts "0) data_CtrlPermissions=#{data_CtrlPermissions}"
#puts "1) CtrlPermissions_db=#{CtrlPermissions_db}"
#puts "1) controllers_and_actions=#{controllers_and_actions}"

	controllers_and_actions.each do |controller_actions|
		#controller_actions[:actions].each do |action|
			CtrlFilters_remove.delete_if{|h| h[0]==controller_actions[:controller] and h[1]==controller_actions[:controller]}
			CtrlPermissions_remove.delete_if{|h| h[0]==CtrlFilter.find(:first,:select => "id",:conditions => [ "(controller = method) AND method = ?",controller_actions[:controller]])[:id]}
		#end
	end
puts "1) data_CtrlFilters that should be remove=#{CtrlFilters_remove}"
unless CtrlFilters_remove.empty?
	CtrlFilters_db.each_with_index do |perm,index|
		if perm[0]==CtrlFilters_remove[0][0] and perm[1]==CtrlFilters_remove[0][1]
			CtrlFilter.destroy(CtrlFilters[index][:id])
			CtrlFilters_remove.shift
		end
		break if CtrlFilters_remove.empty?
	end
end
puts "2) CtrlPermissions_remove=#{CtrlFilters_remove}"

puts "3) data_CtrlPermissions that should be remove=#{CtrlPermissions_remove}"
unless CtrlPermissions_remove.empty?
	CtrlPermissions_db.each_with_index do |perm,index|
		if perm[1]==CtrlPermissions_remove[0][1]
			CtrlPermission.destroy(CtrlPermissions_remove[0][1])
			CtrlPermissions_remove.shift
		end
		break if CtrlPermissions_remove.empty?
	end
end
puts "4) CtrlPermissions_remove=#{CtrlPermissions_remove}"

end
puts "END Remove old controller methods"



