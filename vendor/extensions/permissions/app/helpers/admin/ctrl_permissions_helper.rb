

module Admin::CtrlPermissionsHelper

  def render_node(code, object, options = {})
    @depth ||= 0

    render_tag
    parse_tag
    find_path
    call_filters

    if object.is_a?(CtrlPermission)
      render :partial => 'ctrl_permission', :locals => { :code => code, :permission => object, :hash => nil }
    else
      render :partial => 'ctrl_permission', :locals => { :code => code, :permission => nil, :hash => object }
    end
  end


  def action_links(ctrl_permission)
    returning String.new do |output|
      %w{inactive remove}.each do |action|
        output << link_to(image("#{action}.png"+ ' ' + t('permissions_extension.group.'+action), :alt => action.humanize),
                          url_for(:action => action, :id => ctrl_permission),
                          :method => :post)
#link_to image('minus') + ' ' + t('remove'), remove_admin_group_url(group), :class => "action"
      end
    end
  end

  # tree editor


  # END tree editor

end
