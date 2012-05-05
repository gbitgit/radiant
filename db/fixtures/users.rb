require 'digest/sha1'

pass = '123456'
#salt = '6b88c51cb1500dc9712f8941c0efee2385430977'


users = [
 
{
  :name => 'ADMIN1',
  :login => 'admin1',
  :email => 'admin1@gmail.com',
  :code => 'ADMIN2',
  :admin => 1,
  :designer => :false
},
 
{
  :name => 'AUTHOR1',
  :login => 'author1',
  :email => 'author1@gmail.com',
  :code => 'AUTHOR1',
  :admin => 1,
  :designer => 1
},
 
{
  :name => 'USER1',
  :login => 'user1',
  :email => 'user1@gmail.com',
  :code => 'USER1',
  :admin => :false,
  :designer => :false
}
 
]


User.transaction do 
users.each do |hash|

	hash[:salt] = Digest::SHA1.hexdigest("--#{Time.now}--#{hash[:login]}--sweet harmonious biscuits--")
	hash[:password] = Digest::SHA1.hexdigest("--#{hash[:salt]}--#{pass}--")

	puts hash

	user = User.new
	#user.update_attributes(hash)
	#user.save
hash.each do |attribute,value|
user.update_attribute(attribute,value)
end

end
end


user_groups = [
{
:user_id => 1,
:group_id =>1,
},

{
:user_id => User.find(:first,:conditions=>['code = ?',users[0][:code]])[:id],
:group_id => 2,
},

{
:user_id =>User.find(:first,:conditions=>['code = ?',users[1][:code]])[:id],
:group_id => 3,
},

{
:user_id => User.find(:first,:conditions=>['code = ?',users[2][:code]])[:id],
:group_id => 4,
}

]
	UserGroup.transaction do
	user_groups.each do |hash|
	user_group = UserGroup.new()
	puts "hash=#{hash}"
	#user_group.attributes = hash
	#user_group.save
	user_group.update_attributes(hash)
	user_group.save
	end
	end

user_organizations = [
{
:user_id => 1,
:organization_id =>1,
},

{
:user_id => 1,
:organization_id =>1,
},

{
:user_id => User.find(:first,:conditions=>['code = ?',users[0][:code]])[:id],
:organization_id => 2,
},

{
:user_id =>User.find(:first,:conditions=>['code = ?',users[1][:code]])[:id],
:organization_id => 3,
},

{
:user_id => User.find(:first,:conditions=>['code = ?',users[2][:code]])[:id],
:organization_id => 4,
}

]
	UserOrganization.transaction do
	user_organizations.each do |hash|
	user_organization = UserOrganization.new()
	puts "hash=#{hash}"
	#user_organization.attributes = hash
	#user_organization.save
	user_organization.update_attributes(hash)
	user_organization.save
	end
	end
