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
        p_new = Hash.new(0)
        p_new[:name] = p_hash['Service Name']
        
        provider = Provider.where(:name => p_new[:name]).first_or_create

        provider.age                      = p_hash['Age Range']
        provider.additional_activities_included = p_hash['Additional Activities Included']
        provider.air_conditioning         = p_hash['Air Conditioning']    == 'Y' ? true : false        
        provider.approval_granted_on      = p_hash['Service Approval Granted Date']
        provider.approved_places          = p_hash['Number Of Approved Places']

        provider.bus_service              = p_hash['Bus Service']         == 'Y' ? true : false

        provider.cloth_nappies            = p_hash['Cloth Nappies']       == 'Y' ? true : false
        provider.conditions_on_approval   = p_hash['Conditions on Approval']

        provider.description              = p_hash['Description']
        provider.disposable_nappies       = p_hash['Disposable Nappies']  == 'Y' ? true : false

        provider.excursions               = p_hash['Excursions']          == 'Y' ? true : false

        provider.fee                      = p_hash['Fee']
        provider.food                     = p_hash['Food Provided']       == 'Y' ? true : false

        provider.guest_speakers           = p_hash['Guest Speakers']      == 'Y' ? true : false

        provider.languages                = p_hash['Languages']           == 'Y' ? true : false

        provider.outdoor_play_area        = p_hash['Outdoor Play Area']   == 'Y' ? true : false
        provider.overall_rating           = p_hash['Overall Rating']

        provider.provider_approval_number = p_hash['Provider Approval Number']
        provider.provider_legal_name      = p_hash['Provider Legal Name']

        provider.quality_area_rating_1    = p_hash['Quality Area 1 Rating']
        provider.quality_area_rating_2    = p_hash['Quality Area 2 Rating']
        provider.quality_area_rating_3    = p_hash['Quality Area 3 Rating']
        provider.quality_area_rating_4    = p_hash['Quality Area 4 Rating']
        provider.quality_area_rating_5    = p_hash['Quality Area 5 Rating']
        provider.quality_area_rating_6    = p_hash['Quality Area 6 Rating']
        provider.quality_area_rating_7    = p_hash['Quality Area 7 Rating']

        provider.real_grass               = p_hash['Real Grass']          == 'Y' ? true : false

        provider.security_access          = p_hash['Security Access']     == 'Y' ? true : false
        provider.service_approval_number  = p_hash['Service Approval Number']
        provider.sibling_priority         = p_hash['Sibling Priority']    == 'Y' ? true : false

        provider.technology               = p_hash['Technology']          == 'Y' ? true : false

        provider.url                      = p_hash['Website']       
        provider.vacancies                = p_hash['Vacancies']           == 'Y' ? true : false
        provider.waitlist_fee             = p_hash['Waitlist Fee']    
        provider.waitlist_online          = p_hash['Online Waitlist']     == 'Y' ? true : false
        provider.waitlist_reimbursed      = p_hash['Waitlist Reimbursed'] == 'Y' ? true : false

        provider.attributes.each {|k,v| puts "#{k}:\t\t#{v}"}
        puts provider.description
        if provider.save 
          puts "--Saved\n"
        else
          puts "--Dropped\n"
        end

        address = Address.where(addressable_id: provider[:id], addressable_type: 'Provider').first_or_create
        address.street_address = p_hash['Service Address']
        address.locality       = p_hash['Suburb']
        address.state          = p_hash['State']
        address.post_code      = p_hash['Postcode'] 
        address.attributes.each {|k,v| puts "#{k}:\t\t#{v}"}
        address.save

        #Address.create( addressable_id: provider[:id], addressable_type: 'Provider',
        #  street_address: p_hash['Service Address'], locality: p_hash['Suburb'], 
        #  state: p_hash['state'], post_code: p_hash['post_code'] )
        
        phone = Rolodex.where(rolodexable_id: provider[:id], kind: 'Office number', rolodexable_type: 'Provider').first_or_create
        phone.number_or_email = p_hash['Phone']
        phone.attributes.each {|k,v| puts "#{k}:\t\t#{v}"}
        phone.save        

        #Rolodex.create( rolodexable_id: provider[:id], rolodexable_type: 'Provider',
        #  number_or_email: p_hash['Phone'], kind: 'Office number', when_to_use: 'Anytime' )

        fax = Rolodex.where( rolodexable_id: provider[:id], kind: 'Fax', rolodexable_type: 'Provider').first_or_create
        fax.number_or_email = p_hash['Fax']
        fax.attributes.each {|k,v| puts "#{k}:\t\t#{v}"}
        fax.save

        email = Rolodex.where( rolodexable_id: provider[:id], kind: 'Email', rolodexable_type: 'Provider').first_or_create
        email.number_or_email = p_hash['Email Address']
        email.attributes.each {|k,v| puts "#{k}:\t\t#{v}"}
        email.save

      puts
      end
    end

  	puts "\n--Finished."
    puts "Providers: #{Provider.count}"
    puts "Addresses: #{Address.count}"
    puts "Rolodexes: #{Rolodex.count}"
  end #task
end #namespace


