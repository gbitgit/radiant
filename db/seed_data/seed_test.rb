require 'rubygems'

#system('rake routes|cat >> routes.list')
#file=File.open('routes.list','r+')
#puts file.read

require 'sequel'

yml = (YAML.load(File.read(File.join(RAILS_ROOT,'config/database.yml')))[RAILS_ENV])
#puts yml
#puts yml[:adapter]
#puts yml["adapter"]

DB = Sequel.connect(yml["adapter"].gsub(/postgresql/,'postgres')+'://'+yml["username"]+':'+yml["password"].to_s+'@'+yml["host"]+'/'+yml["database"])
DB.loggers << Logger.new(File.join(RAILS_ROOT,'log',"sequel_#{RAILS_ENV}.log"))

DB.fetch("SELECT * FROM users") do |row|
  puts "Users table DATA= #{row[:name]} #{row[:email]} #{row[:login]} #{row[:salt]}"
end

#dataset = DB["SELECT * FROM users"]
#dataset.map(:email)
#dataset.each{|r| p r}


