namespace :erb do
    namespace :to do
    desc "Converts all .html.erb files to .html.haml"
    task :haml do
        print "looking for erb views..\n"
        #files = find ./vendor/plugins/active_scaffold/frontends/default/views -name *.html.erb
        erbfiles = File.join("vendor/**/views", "*.html.erb")
        rhtmlfiles = File.join("vendor/**/views", "*.rhtml")
        files = Dir.glob(erbfiles)
        files.concat(Dir.glob(rhtmlfiles))
        fd = File.new('erb2haml.sh','w+')
        files.each do |file|
            file.strip!
            #print "parsing file: #{file}\n"
            fd<<"echo parsing file: #{file}\n"
            print "bundle exec html2haml /www/radiant/#{file} | cat >/www/radiant/#{file.gsub(/\.erb$/, ".haml").gsub(/\.rhtml$/,'.html.haml')}\n"#| rm -f #{file}\n"
            fd<< "bundle exec html2haml /www/radiant/#{file} | cat >/www/radiant/#{file.gsub(/\.erb$/, ".haml").gsub(/\.rhtml$/,'.html.haml')}\n"
        end
        files.each do |file|
            file.strip!
            fd << "rm -f #{file}\n"
        end
        system("chmod +x erb2haml.sh")
    end
    end
end