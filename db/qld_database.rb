#
# Provider list from QLD_Database.csv
#
#ServiceApprovalNumber,Provider Approval Number,ServiceName,ProviderLegalName,
#ServiceAddress,Suburb,State,Postcode,Phone,Fax,Email Address,Conditions on Approval,
#NumberOfApprovedPlaces,ServiceApprovalGrantedDate,QualityArea1Rating,QualityArea2Rating,
#QualityArea3Rating,QualityArea4Rating,QualityArea5Rating,QualityArea6Rating,QualityArea7Rating,
#OverallRating,Description,Website,Age Range,Fee,Food Provided,Disposable Nappies,Cloth Nappies,
#Air conditioning,Bus service,Online waitlist,Waitlist Fee,Waitlist reimbursed,Online enrollment,
#Security Access,Additional Activities Included,Excursions,Guest Speakers,Outdoor Play Area,
#Real Grass,Technology,Sibling Priority,Vacancies,Languages

csv_text = File.read('../public/QLD_Database.csv')
csv = CSV.parse(csv_text, :headers => true)
csv.each do |row|
  provider           = row.to_hash
  
  p_new = Provider.find_or_create_by_name(provider['name'])
  p_new.service_approval_number    = provider['ServiceApprovalNumber']
  p_new.approval_number            = provider['Provider Approval Number']
  p_new.service_name               = provider['ServiceName']
  p_new.name                       = provider['ProviderLegalName']
  p_new.conditions_on_approval     = provider['Conditions on Approval']
  p_new.number_of_approved_places  = provider['NumberOfApprovedPlaces']
  p_new.service_approval_granted_on= provider['ServiceApprovalGrantedDate']
  p_new.quality_area_rating_1      = provider['QualityArea1Rating']
  p_new.quality_area_rating_2      = provider['QualityArea2Rating']
  p_new.quality_area_rating_3      = provider['QualityArea3Rating']
  p_new.quality_area_rating_4      = provider['QualityArea4Rating']
  p_new.quality_area_rating_5      = provider['QualityArea5Rating']
  p_new.quality_area_rating_6      = provider['QualityArea6Rating']
  p_new.quality_area_rating_7      = provider['QualityArea7Rating']
  p_new.overall_rating             = provider['OverallRating']
  p_new.description                = provider['Description']
  p_new.fee                        = provider['Fee']

  p_new.additional_activities_included= provider['Additional Activities Included']
  p_new.bus_service                = provider['bus_service']           == 'Y' ? true : false
  p_new.disposable_nappies         = provider['Disposable Nappies']   == 'Y' ? true : false
  p_new.cloth_nappies              = provider['Cloth Nappies']       == 'Y' ? true : false
  p_new.excursions                 = provider['Excursions']         == 'Y' ? true : false
  p_new.food                       = provider['Food Provided']     == 'Y' ? true : false
  p_new.guest_speakers             = provider['Guest_Speakers']   == 'Y' ? true : false
  p_new.hours                      = provider['Hours']
  p_new.age                        = provider['Age']
  p_new.air_conditioning           = provider['Air conditioning']   == 'Y' ? true : false
  p_new.languages                  = provider['Languages']          == 'Y' ? true : false
  p_new.online_enrolment           = provider['Online_enrollment']  == 'Y' ? true : false
  p_new.online_waitlist            = provider['Online waitlist']    == 'Y' ? true : false
  p_new.outdoor_play_area          = provider['outdoor_play_area']  == 'Y' ? true : false
  p_new.real_grass                 = provider['Real_Grass']         == 'Y' ? true : false
  p_new.security                   = provider['Security Access']    == 'Y' ? true : false
  p_new.technology                 = provider['Technology']         == 'Y' ? true : false
  p_new.sibling_priority           = provider['Sibling Priority']   == 'Y' ? true : false
  p_new.vacancies                  = provider['Vacancies']          == 'Y' ? true : false

  p_new.waitlist_fee               = provider['Waitlist Fee']
  p_new.waitlist_reimbursed        = provider['waitlist_reimbursed']== 'Y' ? true : false

  p_new.url                        = provider['Web Site'].to_s.gsub("http://", "")

# [Address]
  p_new.street_address             = provider['ServiceAddress']
  p_new.locality                   = provider['Suburb']
  p_new.state                      = provider['State']
  p_new.post_code                  = provider['Post Code']

# [Rolodex]
  p_new.phone_number               = provider['Phone']
  p_new.fax                        = provider['Fax']
  p_new.email                      = provider['Email Address']

  puts provider
  puts
  p_update = Provider.find_or_create!( provider )

=begin
  if p_new[0] == nil
  	p_new = Provider.create!( name: name, 
                              fee: fee,
                              disposable_nappies: disposable_nappies, 
                              cloth_nappies: cloth_nappies,
      	                      food_provided: food, 
                              hours: hours,
                              age: age,
                              bus_service: bus, 
                              air_conditioning: air_conditioning, 
                              url: url
                            )

    Address.create( addressable_id: p_new[:id], addressable_type: 'Provider',
    	street_address: street_address, locality: locality, state: state, post_code: post_code )

    Rolodex.create( rolodexable_id: p_new[:id], rolodexable_type: 'Provider',
      number_or_email: phone_number, kind: 'Office number', when_to_use: 'Anytime' )

    Rolodex.create( rolodexable_id: p_new[:id], rolodexable_type: 'Provider',
      number_or_email: email, kind: 'Email', when_to_use: 'Anytime' )

  end
  puts p_new.name
=end
end
puts
puts
