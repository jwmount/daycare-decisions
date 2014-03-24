require 'csv'
require 'debugger'

namespace :csv do
  desc "Load provider.csv files"
  task load_providers: :environment do
  	puts "\n\nLoad the provider.csv files found in public/data/providers...."

    Dir.glob("public/data/providers/*.csv").each do |filename|
      puts "\n process file: #{filename}"
    
      csv_text = File.read(filename)
      csv = CSV.parse(csv_text, :headers => true)
      csv.each do |row|

      provider=Hash.new(0)
      new_p = row.to_hash 
      new_p.each do |k,v|
        puts k
        key = k.gsub(' ','_').downcase! unless v.nil?
        provider[key] = new_p[k]
      end

        break if new_p[:name].nil?

        @provider = Provider.where(name: name).first_or_create
        @provider.attributes.each {|k,v| puts "#{k}: #{v}"}
        puts @provider.save!
        puts
      end
    end
  	puts "\n--Finished."
    puts "Total Providers Count: #{Provider.count}"

  end #task
end #namespace

