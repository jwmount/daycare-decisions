require 'debugger'
require 'csv'    

namespace :csv do
  desc "Load provider.csv files"
  task load_providers: :environment do
  	puts "\n\nLoad the provider.csv files found in public/data/providers...."

    puts "1.  Find and create array of files to load."

    Dir.glob("public/data/providers/*.csv").each do |filename|
      puts "\n process file: #{filename}"
    
      CSV.parse(File.read(filename), :headers => true) do |row|
        
        #find the provider name
        name_key = 'Service Name'
        name = row[name_key]
        @provider = Provider.where(name: name ).first_or_create

        @provider.attributes.each do |pk,pv|  
          
          key = pk.gsub('_',' ').split.map(&:capitalize).join(' ')
          if row.has_key?(key)
            @provider[pk] = row[key]
          else  #try with alternate key(s)
            keys = @provider.alternate_keys( key )
            keys.each do |altkey|
              @provider[pk] = row[altkey]
            end
          end  
        @provider.inspect
        puts
        end        
      end
    end

  	puts "\n--Finished."
    puts "Providers: #{Provider.count}"
  end #task
end #namespace


