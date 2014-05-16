# in daycare-decisions, $ rake csv:load_providers
require 'csv'
require 'uri'

namespace :csv do
  desc "Load provider.csv files"

  def sanitize_utf8(string)
    if string.nil?
      'nil'
    else
      puts '...sanitize: ' + string
    end
    return nil if string.nil?
    return string if string.valid_encoding?
    string.chars.select { |c| c.valid_encoding? }.join
  end

  def townify
    towns = ["Brisbane", "Southport", "Broadbeach", "Mooloombaba", "Indiroopulli"]
    town = towns[rand(5)]
  end

  def statify
    states = ["QLD", "NSW", "NT", "VIC", "SA", "WA", "TAS"]
    state = states[rand(7)]
  end

#
# LOAD PROVIDERS
# $ rake csv:load_providers
#
  task load_providers: :environment do
    
  	puts "\n\nLoad the provider.csv files found in public/data/providers...."

    Dir.glob("public/data/providers/*.csv").each do |filename|
      puts "\n process file: #{filename}"
    
      CSV.parse(File.read(filename), :encoding => "iso-8859-1", :headers => true) do |row|

        # Create new hash for provider by sanitizing each element in row.  See
        # If row begins with '#' it's a comment.
        # Gist 'Invalid UTF8 in .csv' for discussion of this.     
        p_hash = Hash.new(nil)
        if row.index(/[# ]/, 0) 
          puts row
          break
        else
          row.each do |k,v|
            p_hash[k] = sanitize_utf8(v)
          end
        end

        # get provider if one exists (validated to unique so only one can exist) or
        # create new one.
        provider = Provider.where(:name => p_hash['ServiceName']).first_or_create
        provider.age_range                  = p_hash['Age Range']
        provider.additional_activities      = p_hash['Additional Activities'] == ('Y' || 'T')
        provider.additional_activities_list = p_hash['Additional Activities List']
        provider.air_conditioning           = p_hash['Air conditioning'] == ('Y' || 'T') ? true : false
   #     provider.approval_granted_on      = p_hash['ServiceApprovalGrantedDate']
        provider.approved_places          = p_hash['NumberOfApprovedPlaces']

        provider.bus_service              = p_hash['Bus service']         == ('Y' || 'T') ? true : false

        provider.care_offered             = p_hash['Type of Care']
        provider.cloth_nappies            = p_hash['Cloth Nappies']       == ('Y' || 'T') ? true : false
        provider.conditions_on_approval   = p_hash['Conditions on Approval']

        provider.description              = p_hash['Description']
        provider.disposable_nappies       = p_hash['Disposable Nappies']  == ('Y' || 'T') ? true : false

        provider.extended_hours_for_kindys= p_hash['Extended Hours For Kindys'] == ('Y' || 'T') ? true : false

        provider.excursions               = p_hash['Excursions']          == ('Y' || 'T') ? true : false

        provider.fee                      = p_hash['Fees']
        provider.food_provided            = p_hash['Food Provided']       == ('Y' || 'T') ? true : false

        provider.guest_speakers           = p_hash['Guest Speakers']      == ('Y' || 'T') ? true : false

        provider.kindergarten             = p_hash['Kindergarten']        == ('Y' || 'T') ? true : false
        provider.languages                = (p_hash['Languages']          == 'Y' || 'T')
        provider.languages_list           = p_hash['Languages List']

        provider.name                     = p_hash['ServiceName']

        provider.outdoor_play_area        = p_hash['Outdoor Play Area']   == ('Y' || 'T') ? true : false

        provider.provider_approval_number = p_hash['Provider Approval Number']
        provider.provider_legal_name      = p_hash['ProviderLegalName']

        provider.quality_area_rating_1    = p_hash['QualityArea1Rating']
        provider.quality_area_rating_2    = p_hash['QualityArea2Rating']
        provider.quality_area_rating_3    = p_hash['QualityArea3Rating']
        provider.quality_area_rating_4    = p_hash['QualityArea4Rating']
        provider.quality_area_rating_5    = p_hash['QualityArea5Rating']
        provider.quality_area_rating_6    = p_hash['QualityArea6Rating']
        provider.quality_area_rating_7    = p_hash['QualityArea7Rating']
        provider.quality_overall_rating   = p_hash['OverallRating']

        provider.real_grass               = p_hash['Real Grass']          == ('Y' || 'T') ? true : false

        provider.security_access          = p_hash['Security Access']     == ('Y' || 'T') ? true : false
        provider.service_approval_number  = p_hash['ServiceApprovalNumber']
        provider.sibling_priority         = p_hash['Sibling Priority']    == ('Y' || 'T') ? true : false

        provider.technology              = p_hash['Technology'] == ('Y' || 'T') ? true : false
        provider.technology_list         = p_hash['Technology_list']

        provider.url                      = p_hash['Website'] 

        provider.vacancies                = p_hash['Vacancies'] == ('Y' || 'T') ? true : false     
        provider.vacancies_list           = p_hash['Vacancies_list']
        provider.vaccinations_compulsory  = p_hash['Vaccinactions Compulsory'] == ('Y' || 'T') ? true : false
        provider.waitlist_fee             = p_hash['Waitlist Fee']    
        provider.waitlist_online          = p_hash['Online waitlist']     == ('Y' || 'T') ? true : false
        provider.waitlist_reimbursed      = p_hash['Waitlist refundable'] == ('Y' || 'T') ? true : false

        #provider.attributes.each {|k,v| puts "#{k}:\t\t#{v}"}


        # Save provider but only create polymorphic dependents if name given and 
        # save is successful.
        if !provider.name.nil? and provider.save! 
          puts "--#{provider.name} from #{filename} Saved\n\n\n"

          address = Address.where(addressable_id: provider[:id], addressable_type: 'Provider').first_or_create
          address.street         = p_hash['Service Address']
          address.locality       = p_hash['Suburb'].split.map(&:capitalize).*(' ')
          address.state          = p_hash['State']
          address.post_code      = p_hash['4000'] 
         # address.attributes.each {|k,v| puts "#{k}:\t\t#{v}"}
          address.save

          phone = Rolodex.where(rolodexable_id: provider[:id], kind: 'Office number', rolodexable_type: 'Provider').first_or_create
          phone.number_or_email = p_hash['Phone']
         # phone.attributes.each {|k,v| puts "#{k}:\t\t#{v}"}
          phone.save        
=begin
  return these once database row limit is raised, using these puts us over the 
  10,000 row limit at Heroku.
  
          fax = Rolodex.where( rolodexable_id: provider[:id], kind: 'Fax', rolodexable_type: 'Provider').first_or_create
          fax.number_or_email = p_hash['Fax']
         # fax.attributes.each {|k,v| puts "#{k}:\t\t#{v}"}
          fax.save

          email = Rolodex.where( rolodexable_id: provider[:id], kind: 'Email', rolodexable_type: 'Provider').first_or_create
          email.number_or_email = p_hash['Email Address']
         # email.attributes.each {|k,v| puts "#{k}:\t\t#{v}"}
          email.save
=end
        else
          puts "--Provider could not be saved, Dropped\n"
        end
      
      puts "\n\n"
      end
    end
  	puts "\n--Finished."
    puts "Providers: #{Provider.count}"
    puts "Addresses: #{Address.count}"
    puts "Rolodexes: #{Rolodex.count}"
  end #task

#
# L O A D  T E S T
#
  task load_test_providers: :environment do
  
    @count = 0
    @started = Time.now()
    100.times do 
    
      provider = Provider.where(:name => "Service Name-#{rand(3000).to_s}").first_or_create
      provider.age_range                = 'Age Range'
      provider.additional_activities    = rand( 2 )
      provider.additional_activities_list = "Physikids"
      provider.air_conditioning         = rand( 2 )
      provider.approval_granted_on      = Date.today
      provider.approved_places          = 40

      provider.bus_service              = rand( 2 )
      
      provider.care_offered             = 'Long Day Care'
      provider.cloth_nappies            = rand( 2 )
      provider.conditions_on_approval   = 'Conditions on Approval'
      
      provider.description              = 'Description'
      provider.disposable_nappies       = rand( 2 )
      
      provider.extended_hours_for_kindys= rand( 2 )
      provider.excursions               = rand( 2 )
      
      provider.fee                      = rand( 200 )
      provider.food_provided            = rand( 2 )
      
      provider.guest_speakers           = rand( 2 )
      
      provider.kindergarten             = rand(2)
      provider.languages                = rand(2)
      provider.languages_list           = "French"
      
      provider.outdoor_play_area        = rand( 2 )
      
      provider.provider_approval_number = 'Provider Approval Number'
      provider.provider_legal_name      = 'Provider Legal Name'
      
      provider.quality_area_rating_1    = 'Quality Area 1 Rating'
      provider.quality_area_rating_2    = 'Quality Area 2 Rating'
      provider.quality_area_rating_3    = 'Quality Area 3 Rating'
      provider.quality_area_rating_4    = 'Quality Area 4 Rating'
      provider.quality_area_rating_5    = 'Quality Area 5 Rating'
      provider.quality_area_rating_6    = 'Quality Area 6 Rating'
      provider.quality_area_rating_7    = 'Quality Area 7 Rating'
      provider.quality_overall_rating   = 'Quality Rating'

      provider.real_grass               = rand( 2 )
      
      provider.security_access          = rand( 2 )
      provider.service_approval_number  = 'Service Approval Number'
      provider.sibling_priority         = rand( 2 )
      
      provider.technology              = rand( 2 )
      provider.technology_list         = "iPads"
      
      provider.url                      = 'www.wsj.com'       
      provider.vacancies                = rand( 2 )
      provider.vacancies_list           = "Ages 6-12 months: 2"
      provider.vaccinations_compulsory  = rand( 2 )
      provider.waitlist_fee             = 25.00
      provider.waitlist_online          = rand( 2 )
      provider.waitlist_reimbursed      = rand( 2 )
      
        # Save provider but only create polymorphic dependents if successful.
        if provider.save!
          @count += 1
          puts "--Saved #{@count.to_s}"

          address = Address.where(addressable_id: provider[:id], addressable_type: 'Provider').first_or_create
          address.street         = "#{rand(200).to_s} Iveery St."
          address.locality       = townify
          address.state          = statify
          address.post_code      = '4000'
          address.save

          phone = Rolodex.where(rolodexable_id: provider[:id], kind: 'Office number', rolodexable_type: 'Provider').first_or_create
          phone.number_or_email = '+61 423 999 000'
          phone.save        

          fax = Rolodex.where( rolodexable_id: provider[:id], kind: 'Fax', rolodexable_type: 'Provider').first_or_create
          fax.number_or_email = '+61 (0)4 2399 9000'
          fax.save

          email = Rolodex.where( rolodexable_id: provider[:id], kind: 'Email', rolodexable_type: 'Provider').first_or_create
          email.number_or_email = 'info@daycaredecisions.com.au'
          email.save
        else
          puts "--Dropped\n"
        end

      end # do
    @finished = Time.now()
    rate = (@finished - @started)/@count
    puts "\n--Finished.  average rate: #{rate}"
    puts "Providers: #{Provider.count}"
    puts "Addresses: #{Address.count}"
    puts "Rolodexes: #{Rolodex.count}"
  end #task

end #namespace

