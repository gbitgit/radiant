organizations = [

{
:code => 'DEFAULT',
:desc => 'default organization',
:parent_id => nil
},

{
:code => '01',
:desc => 'default 01 organization',
:parent_id => 1
},

{
:code => '02',
:desc => 'default 01 organization',
:parent_id => 2
},

{
:code => '03',
:desc => 'default 01 organization',
:parent_id => nil
},

]

Organization.transaction do
organizations.each do |hash|
puts "hash=#{hash}"
organization = Organization.new
organization.update_attributes(hash)
end
end
