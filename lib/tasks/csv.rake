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
        p_hash = row.to_hash
        provider = p_hash['Service Name'].gsub[' ','_'].downcase

        provider = Provider.create.where(:name => name).first_or_create
        provider.inspect
        puts
      end
    end

  	puts "\n--Finished."
    puts "Providers: #{Provider.count}"
  end #task
end #namespace


