require 'csv'    

namespace :csv do
  desc "Load provider.csv files"
  task load_providers: :environment do
  	puts "\n\nLoad the provider.csv files found in public/data/providers...."

    puts "1.  Find and create array of files to load."

    Dir.glob("public/data/providers/*.csv").each do |filename|
      puts "\n process file: #{filename}"
    
      CSV.parse(File.read(filename), :headers => true) do |row|
        @new_provider = row.to_hash  
        @provider = Provider.new
        @provider.attributes.each do |pk,pv|  
          key = pk.gsub('_',' ').split.map(&:capitalize).join(' ')
          if @new_provider.has_key?(key)
            @provider[pk] = @new_provider[key]
          end
        end
        
        @provider.save

        #Provider.create!(row.to_hash)
        puts "3.  Create newp object with validiation methods for each attribute"
        puts "4.  For each file do"
        puts "5.      itereate rows"
        puts "6.        iterate newp keys"
        puts "7.          assign k,v "
        puts "8              newp[k] = candidate[k,v]"
        puts "9                begin - rescue exceptions"
      end
    end

    puts "Processed files."
  	puts "\n--Finished."
  end #task
end #namespace


