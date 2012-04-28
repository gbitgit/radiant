groups = [

{
:code => 'root',
:desc => 'super users = global admins'
},

{
:code => 'admins',
:desc => 'local admins'
},

{
:code => 'authors',
:desc => 'authors'
},

{
:code => 'users',
:desc => 'users'
}

]

Group.transaction do
groups.each do |hash|
puts "hash=#{hash}"
group = Group.new
group.update_attributes(hash)
end
end


=begin
Factory.define :theme do |t|
  t.background_color '0x000000'
  t.title_text_color '0x000000',
  t.component_theme_color '0x000000'
  t.carrier_select_color '0x000000'
  t.label_text_color '0x000000',
  t.join_upper_gradient '0x000000'
  t.join_lower_gradient '0x000000'
  t.join_text_color '0x000000',
  t.cancel_link_color '0x000000'
  t.border_color '0x000000'
  t.carrier_text_color '0x000000'
  t.public true
end

Factory(:theme, :id => 1, :name => "Lite", :background_color => '0xC7FFD5')
Factory(:theme, :id => 2, :name => "Metallic", :background_color => '0xC7FFD5')
Factory(:theme, :id => 3, :name => "Blues", :background_color => '0x0060EC')

100.times do
    Factory(:company, :address => Factory(:address), :employees => [Factory(:employee)])
end

=end

