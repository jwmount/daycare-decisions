# in daycare-decisions, $ rake csv:load_providers
require 'csv'
require 'uri'

namespace :load do
  desc "Main database load task"
  task :main => :environment do
    Rake::Task['load:load_providers'].invoke
    Rake::Task['load:load_test_providers'].invoke
  end

#namespace :csv do

#  desc "BEGIN:  Load provider data."

#
# LOAD PROVIDERS 
# Default is Australian providers
# $ rake csv:load_providers
#
  task load_providers: :environment do
    @total_count = 0
    @file_count = 0
    @started = Time.now()
    
    Provider.delete_all
    puts "\n\nDELETED ALL PROVIDERS"
    Address.delete_all
    puts "DELETED ALL ADDRESSES"
    Rolodex.delete_all
    puts "DELETED ALL ROLODEXES"
    puts "\n\n"
    puts "\n\nLoad the provider.csv files found in public/data/providers...."

    Dir.glob("public/data/au/providers/*.csv").each do |filename|
      puts "\n process file: #{filename}"
    
      CSV.parse(File.read(filename), :encoding => "iso-8859-1", :headers => true) do |row|

        @total_count += 1
        @file_count += 1
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
#        provider = Provider.where(:name => p_hash['ServiceName']).first_or_create
        provider = Provider.new
        provider.address                    = construct_address p_hash
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
        provider.disability_friendly      = p_hash['Disability Friendly'] == ('Y' || 'T')
        provider.disabilities_list        = p_hash['Disabilities List']
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

        provider.secure_access            = p_hash['Secure Access']       == ('Y' || 'T') ? true : false
        provider.service_approval_number  = p_hash['ServiceApprovalNumber']
        provider.sibling_priority         = p_hash['Sibling Priority']    == ('Y' || 'T') ? true : false

        provider.technology               = p_hash['Technology']          == ('Y' || 'T') ? true : false
        provider.technologies_list        = p_hash['Technologies List']

        provider.url                      = p_hash['Website'] 

        provider.vacancies                = p_hash['Vacancies']           == ('Y' || 'T') ? true : false     
        provider.vacancies_list           = p_hash['Vacancies List']
        provider.vaccinations_compulsory  = p_hash['Vaccinactions Compulsory'] == ('Y' || 'T') ? true : false
        provider.waitlist_fee             = p_hash['Waitlist Fee']    
        provider.waitlist_online          = p_hash['Online waitlist']     == ('Y' || 'T') ? true : false
        provider.waitlist_reimbursed      = p_hash['Waitlist refundable'] == ('Y' || 'T') ? true : false


        # Save provider but only create polymorphic dependents if name given and 
        # save is successful.
        if !provider.name.nil? and provider.save! 
          puts "#{@total_count}/#{@file_count}--Create #{provider.name}  #{filename}."

          source = Source.where(sourceable_id: provider[:id], sourceable_type: 'Provider').first_or_create
          source.name = filename
          source.description = "csv:load_*"
          source.save

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
          puts "--Provider #{@file_count} in #{filename} was not be saved.  Name apparently missing.\n"
          puts "--Name:  #{provider.name}" unless provider.name.nil?
        end
      
      end
      puts "]\n#{filename}: #{@file_count}.\n\n"
      @file_count = 0
    end

  	puts "\n--Finished."
    puts "Providers: processed: #{@total_count}, have: #{Provider.count}"
    puts "Addresses: #{Address.count}"
    puts "Rolodexes: #{Rolodex.count}"

    puts "Elapsed time: #{(Time.now() - @started)}"

  end #task

#
# L O A D  T E S T
#
  task load_test_providers: :environment do
  
    @count = 0
    @started = Time.now()
    10.times do 
    
      provider = Provider.where(:name => "Test Provider-#{rand(3000).to_s}").first_or_create
      provider.age_range                = ageify
      provider.additional_activities    = rand( 2 )
      provider.additional_activities_list = "Physkids, Wizkids, Bizkids"
      provider.air_conditioning         = rand( 2 )
      provider.approval_granted_on      = Date.today
      provider.approved_places          = 40

      provider.bus_service              = rand( 2 )
      
      provider.care_offered             = 'Long Day Care'
      provider.cloth_nappies            = rand( 2 )
      provider.conditions_on_approval   = 'Conditions on Approval'
      
      provider.description              = 'DATA about services offered is SIMULATED ...'
      provider.disability_friendly      = rand( 2 )
      provider.disabilities_list        = 'ADD, Allergies, Diet restrictions'
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
      
      provider.secure_access            = rand( 2 )
      provider.service_approval_number  = 'Service Approval Number'
      provider.sibling_priority         = rand( 2 )
      
      provider.technology               = rand( 2 )
      provider.technologies_list        = "iPads"
      
      provider.url                      = 'www.wsj.com'       
      provider.vacancies                = rand( 2 )
      provider.vacancies_list           = "Ages 6-12 months: 2"
      provider.vaccinations_compulsory  = rand( 2 )
      provider.waitlist_fee             = 25.00
      provider.waitlist_online          = rand( 2 )
      provider.waitlist_reimbursed      = rand( 2 )
      
      # HACK -- Move address into Provider using :address serialized column.
      provider.address = "#{rand(200).to_s} Iveery St., " + townify + ", " + statify + ' 4000'

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

#
# LOAD US PROVIDERS 
# $ rake csv:load_providers
#
# CA CSS data columns are:
# "Facility #","Capacity","License Status","Facility Name",
# "Street Address","City","State","Zipcode","Telephone #",
# "Contact","District Office","DO Telephone #"
#
# For the CA load, aka load_us_providers, :description is used to 
# display attributes no in Providers as currently modeled. 
#

  task load_us_providers: :environment do
    
    @started = Time.now()
    @count = 0 

    puts "\n\nLoad US providers.\n"

    Dir.glob("public/data/us/providers/*.csv").each do |filename|
      puts "\n process file: #{filename}"
    
      CSV.parse(File.read(filename), :encoding => "iso-8859-1", :headers => true) do |row|

        # Create new hash for provider by sanitizing each element in row.  See
        # If row begins with '#' it's a comment.
        # Gist 'Invalid UTF8 in .csv' for discussion of this.     
        p_hash = Hash.new(nil)
        @count = @count + 1
        if row.index(/[# ]/, 0) 
          puts row
          next
        else
          row.each do |k,v|
            p_hash[k] = sanitize_utf8(v)
          end
        end

        puts @count

        # get provider if one exists (validated to unique so only one can exist) or
        # create new one.
        provider = Provider.where(:name => p_hash['Facility Name']).first_or_create
        provider.name ||= p_hash['Facility Name']
        provider.approved_places = p_hash['Capacity']
        provider.address = [ p_hash['Street Address'],
                             p_hash['City'],
                             p_hash['State'],
                             p_hash['Zipcode']
                           ].join(", ")

        provider.description = [
                       ["Facility #:         #{p_hash['Facility #']}"],
                       ["Contact:            #{p_hash['Contact']}"],
                       ["License Status:     #{p_hash['License Status']}"],
                       ["District Office:    #{p_hash['District Office']}"],
                       ["DO Telephone:       #{p_hash['DO Telephone #']}"]
                      ].join('; ')

        # Save provider but only create polymorphic dependents if name given and 
        # save is successful.
        if !provider.name.nil? and provider.save! 
          puts "--#{provider.name} from #{filename} Saved\n\n\n"

          address = Address.where(addressable_id: provider[:id], addressable_type: 'Provider').first_or_create
          address.street         = p_hash['Street Address']
          address.locality       = p_hash['City']
          address.state          = p_hash['State']
          address.post_code      = p_hash['Zipcode'] 
         # address.attributes.each {|k,v| puts "#{k}:\t\t#{v}"}
          address.save

          phone = Rolodex.where(rolodexable_id: provider[:id], kind: 'Office number', rolodexable_type: 'Provider').first_or_create
          phone.number_or_email = p_hash['Telephone #']
         # phone.attributes.each {|k,v| puts "#{k}:\t\t#{v}"}
          phone.save        
        else
          puts "--Provider could not be saved, Dropped\n"
        end
      
      end
    end

    puts "\n--Finished."
    puts "Providers: #{Provider.count}"
    puts "Addresses: #{Address.count}"
    puts "Rolodexes: #{Rolodex.count}"

    puts "Elapsed time: #{(Time.now() - @started)}"
  end #task

#
# helper methods
#
  def construct_address (p_hash)
    addr = []
    addr << p_hash['Service Address'] unless p_hash['Service Address'].nil?
    addr << p_hash['locality'] unless p_hash['locality'].nil?
    addr << p_hash['state'] unless p_hash['state'].nil?
    addr << p_hash['post_code'] unless p_hash['post_code'].nil?
    return addr.join(', ') unless addr.nil?
  end

  def sanitize_utf8(string)
    return nil if string.nil?
    return string if string.valid_encoding?
    string.chars.select { |c| c.valid_encoding? }.join
  end

  # Create a set of age ranges
  def ageify
    ages = ["2 to 12 months", "12 to 24 months", "2 to 4 years"]
    age = ages[rand(3)]
  end

  # Use three forms of capitalization so we can work on case sensitivity
  def townify
    #towns = ["Brisbane", "Southport", "Broadbeach", "Mooloombaba", "Indiroopulli"]
    #towns = ["Abcville", "abcville"]
    #town = towns[rand(2)]
    # force single town for testing
    town = "Abcville"
  end

  # So far we don't know town names outside of QLD, so stay there
  def statify
    #states = ["QLD", "NSW", "NT", "VIC", "SA", "WA", "TAS"]
    #state = states[rand(7)]
    # Force to single state for testing
    state = 'QLD'
  end


end #namespace

