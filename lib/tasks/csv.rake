require 'debugger'
require 'csv'    

namespace :csv do
  desc "Load provider.csv files"
  task load_providers: :environment do
  	puts "\n\nLoad the provider.csv files found in public/data/providers...."

    puts "1.  Find and create array of files to load."

    Dir.glob("public/data/providers/*.csv").each do |filename|
      puts "\n process file: #{filename}"
      csv_text = File.read(filename)
      csv = CSV.parse(csv_text, :headers => true)
      csv.each do |row|
        @provider = Provider.new
        @provider.attributes.each do |k,v|  

          key = k.gsub('_',' ').split.map(&:capitalize).join(' ')
        
          if row.has_key?(key)
            @provider[k] = row[key]
          else  #try with alternate key(s)
            keys = @provider.alternate_keys( key )
            keys.each do |altkey|
              debugger
              @provider.update( {altkey => row[altkey]} )
            end
          end  
        end        

        puts @provider.inspect
        @provider.save! unless @provider.name.nil?
        System.exit
      end
    end 
  	puts "\n--Finished."
    puts "Total Providers Count: #{Provider.count}"
  end #task
end #namespace


