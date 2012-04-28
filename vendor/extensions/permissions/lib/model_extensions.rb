#UserModelExtensions = Proc.new do
#  has_many :group
#  has_many :organization
  
#  def group_owners
#    self.group.nil? ? [] : self.group.users
#  end
  
#  def group_name
#    self.group.nil? ? '' : self.group.name
#  end

#end

#UserModelExtensions = Proc.new do
#  has_and_belongs_to_many :groups
#  has_and_belongs_to_many :organizations
#end
