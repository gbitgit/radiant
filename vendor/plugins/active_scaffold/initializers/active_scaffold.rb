#def refresh
#    p = params[:controller]
#    render :update do |page|
#      page["#{p}-active-scaffold"].replace_html render_component(:controller => p)
#    end unless p.nil?
#end

#ActiveScaffold.set_defaults do |config|
  #config.ignore_columns.add [:created_at, :updated_at,:created_by, :updated_by, :lock_version]
#  config.list.columns.exclude       :created_at, :updated_at,:created_by, :updated_by
#  config. create.columns.exclude :id,:created_at, :updated_at,:created_by, :updated_by
#  config.update.columns.exclude :id,:created_at, :updated_at,:created_by, :updated_by
  # adding the refresh button
#  config.action_links.add('refresh', :label => l(:active_scaffold, :refresh), :inline => true, :position => false)
#end
