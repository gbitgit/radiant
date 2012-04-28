module UserExtension
  def self.included(base)
    base.has_many :groups, :class_name => 'UserGroup'
    base.has_many :organizations, :class_name => 'UserOrganization'
  end

  # Does this user have the necessary priviledges to execute a given action?
  #def can?(action, page)
    #permissions.count(:conditions => ['page_id = ? AND action = ?', page.id, action.to_s]) > 0
    #ctrl_permissions.count(:conditions => ['page_id = ? AND action = ?', page.id, action.to_s]) > 0
  #end
end
