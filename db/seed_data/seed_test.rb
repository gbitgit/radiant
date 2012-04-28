require 'find'

system('rake routes|cat >> routes.list')
file=File.open('routes.list','r+')
puts file.read
