module Admin::GroupsHelper
  def render_node(id, object, options = {})
    @depth ||= 0

    if object.is_a?(Group)
      render :partial => 'group', :locals => { :id => id, :group => object, :hash => nil }
    else
      render :partial => 'group', :locals => { :id => id, :group => nil, :hash => object }
    end
  end

  def order_links(group)
    returning String.new do |output|
      %w{move_to_top move_higher move_lower move_to_bottom}.each do |action|
        output << link_to(image("#{action}.png", :alt => action.humanize),
                          url_for(:action => action, :id => group),
                          :method => :post)
      end
    end
  end

  def action_links(group)
    returning String.new do |output|
      %w{inactive remove}.each do |action|
        output << link_to(image("#{action}.png"+ ' ' + t('permissions_extension.group.'+action), :alt => action.humanize),
                          url_for(:action => action, :id => group),
                          :method => :post)
#link_to image('minus') + ' ' + t('remove'), remove_admin_group_url(group), :class => "action"
      end
    end
  end

end