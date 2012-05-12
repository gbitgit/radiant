require 'find'


#Since Rails doesn't load classes unless it needs them, you must read the models from the folder. Here is the code

    model_directory = "#{RAILS_ROOT}/app/models/"
    ext_model_directory = "#{RAILS_ROOT}/vendor/extensions/"
    model_files = []
    models_list = []
    Find.find(model_directory) do |node|
      next unless (node.match(/app\/models/) and node.match(/.rb$/))
      if FileTest.file?(node)
        #model_files << node.gsub("#{model_directory}","")
#puts node#.gsub("models","models").gsub(/s?_model/,"")
  begin
    require node#.gsub("models","models").gsub(/s?_model/,"")
  rescue
  end
      end
    end
    Find.find(ext_model_directory) do |node|
      next unless (node.match(/app\/models/) and node.match(/.rb$/))
      if FileTest.file?(node)
        #model_files << node.gsub("#{ext_model_directory}","") if node.match(/.*_model.rb/)
puts node#.gsub("models","models").gsub(/s?_model/,"")
  begin
    require node#.gsub("models","models").gsub(/s?_model/,"")
  rescue
  end
  end
  end


=begin
puts "*******************************"
puts "List of model_actions"
puts "*******************************"


model_actions = Actionmodel::Routing::Routes.routes.inject({}) do |model_actions, route|
      (model_actions[route.requirements[:model]] ||= []) << route.requirements[:action]
model_actions
end

model_actions.each do |c|
  puts "model: #{c[0]}\n"
  puts "Actions: #{c[1]}\n\n"
#  puts "Actions: #{eval("#{c[0].camelize.gsub('/','')}.new.action_methods").collect{|a| a.to_s}.join(', ')}\n\n"
end

# returns 'Actions: ["admin/configuration", ["new", "edit", "show", "update", "destroy", "create"]]'
=end


puts "*******************************"
puts "List of models"
puts "*******************************"

models_list=[{}]

    model_directory = "#{RAILS_ROOT}/app/models/"
    ext_model_directory = "#{RAILS_ROOT}/vendor/extensions/"
    model_files = []
    models_list = []
    Find.find(model_directory) do |node|
      next unless (node.match(/app\/models/) and node.match(/.rb$/))
      if FileTest.file?(node)
	puts node.gsub("#{model_directory}","")
        model_files << node.gsub("#{model_directory}","")
      end
    end
    Find.find(ext_model_directory) do |node|
      next unless (node.match(/models/) and node.match(/.rb$/))
      if FileTest.file?(node)
        model_files << node if node.match(/.*\.rb/)
	puts node.gsub("#{ext_model_directory}","")
      end
    end

    model_files.each do |model_file|
      if model_file =~ /\.rb/
        puts "model_file = #{model_file}"
        model_path = model_file.gsub(/\.rb/,"")
        model = model_file.gsub("#{ext_model_directory}","").camelize.gsub(".rb","").gsub("/","::").gsub(/.*::Models::/,'') 
	puts model

puts "************  #{model} ************"
#puts actions
        models_list << { :model => model.gsub("::",'') }
      end
    end

puts "*******************************"
puts "*******************************"
puts "END of List of model_actions"
puts "*******************************"
puts "*******************************"

puts "BEGIN of add new data filter records AKA Rails models"

DataFilter.transaction do 
admin=User.find_by_login('admin')
admin_groups=Group.find(:all,:conditions => [ "code = ? or code = ? ",'root','admins'],:select => "id").collect!{|a| a.id}

#insert DataPermission model's nodes first
models_list.each do |model_actions|
				attributes=
				{
				  :code =>(model_actions[:model].humanize.to_s+' entity').upcase,
				  :desc =>(model_actions[:model].humanize.to_s+' entity'),
				  :model =>model_actions[:model],
				  :created_by =>admin[:id],
				  :updated_by =>admin[:id],
				}
	data_filter = DataFilter.new
	data_filter.update_attributes(attributes)
	data_filter.save
end

end

puts "END of add new data filter records"

puts "BEGIN of add new Control Permissions records AKA link from user group to Rails models"

DataPermission.transaction do 
admin=User.find_by_login('admin')
groups=Group.find(:all)
orgs=Organization.find(:all)
admin_groups=Group.find(:all,:conditions => [ "code = ? or code = ? ",'root','admins'],:select => "id").collect!{|a| a.id}

data_filters=DataFilter.find(:all)

#insert DataPermission model's nodes first
data_filters.each do |data_filter|

groups.each do |group|
orgs.each do |org|

				attributes=
				{
				  :code =>(data_filter[:model].humanize).upcase,
				  :desc =>(data_filter[:model].humanize),
				  :organization_id =>org[:id],
				  :group_id =>group[:id],
				  :data_filter_id =>data_filter[:id],
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
				
	data_permission = DataPermission.new
	data_permission.update_attributes(attributes)
	data_permission.save
end
end
end
end
puts "END of add new model methods"

puts "Remove old model methods"

DataFilter.transaction do 
	DataFilters=DataFilter.find(:all,:select => "DISTINCT id,model")
	DataFilters_db= DataFilters.collect{|a| [a.model,a.id]}
	DataFilters_remove=DataFilters_db.dup

	DataPermissions_db=DataPermission.find(:all,:select => "DISTINCT id,data_filter_id").collect{|a| [a.data_filter_id,a.id]}
	DataPermissions_remove=DataPermissions_db.dup

#puts "0) data_DataPermissions=#{data_DataPermissions}"
#puts "1) DataPermissions_db=#{DataPermissions_db}"
#puts "1) models_list=#{models_list}"

	models_list.each do |models|

			DataPermissions_remove.delete_if{|h| h[0]==DataFilter.find(:first,:select => "id",:conditions => [ " model = ? ",models[:model]])[:id]}
			DataFilters_remove.delete_if{|h| h[0]==models[:model]}

	end

puts "1) data_DataFilters that should be remove=#{DataFilters_remove}"
unless DataFilters_remove.empty?
	DataFilters_db.each_with_index do |perm,index|
		if perm[0]==DataFilters_remove[0][0] and perm[1]==DataFilters_remove[0][1]
			DataFilter.destroy(DataFilters[index][:id])
			DataFilters_remove.shift
		end
		break if DataFilters_remove.empty?
	end
end
puts "2) DataPermissions_remove=#{DataFilters_remove}"

puts "3) data_DataPermissions that should be remove=#{DataPermissions_remove}"
unless DataPermissions_remove.empty?
	DataPermissions_db.each_with_index do |perm,index|
		if perm[1]==DataPermissions_remove[0][1]
			DataPermission.destroy(DataPermissions_remove[0][1])
			DataPermissions_remove.shift
		end
		break if DataPermissions_remove.empty?
	end
end
puts "4) DataPermissions_remove=#{DataPermissions_remove}"

end
puts "END Remove old model methods"



