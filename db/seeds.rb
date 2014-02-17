require 'csv'    
require 'debugger'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
roles_list = %w[ admin management parent superadmin ]
roles_list.each do |role|
  Role.create!(name: role)
end

# Create users (roles not implemented yet, MUST be chosen from roles_list)
user_list = [
  ['john@venuesoftware.com', 'password', 4],
  ['rebecca@daycaredecisions.com', 'password', 1],
  ['rebecca@daycaredecisions.com.au', 'password', 1],
  ['parent@parents.com', 'password', 3]
  ]

user_list.each do |email, password, role|  
  user = AdminUser.where( email: email )
  if user[0] == nil
  	AdminUser.create( email: email, password: password, password_confirmation: password, role_id: role)
  end
  Rails::logger.info( "*-*-*-*-* Created user #{email}, pswd: #{password.slice(0..2)}, role: #{role}" )
end

#
# Provider list for Brisbane
#
csv_text = File.read('public/DaycareDecisionsChildCareCentreDatabasev2.csv')
csv = CSV.parse(csv_text, :headers => true)
csv.each do |row|
  #Provider.create!(row.to_hash)
  provider           = row.to_hash
  name               = provider['Name']
  fee                = provider['Fees']
  disposable_nappies = provider['Disposable Nappies']
  cloth_nappies      = provider['Cloth Nappies']
  food               = provider['Food']
  hours              = provider['Hours']
  age                = provider['Age']
  bus                = provider['Bus']
  air_conditioning   = provider['Air conditioning']
  url                = provider['Web Address'].to_s.gsub("http://", "")

  street             = provider['Address']
  suburb             = provider['Suburb']
  state              = provider['State']
  post_code          = provider['Post Code']

  phone_number       = provider['Phone Number']
  email              = provider['Email']

  p_new = Provider.where( name: name )
  if p_new[0] == nil
  	p_new = Provider.create( name: name, disposable_nappies: disposable_nappies, cloth_nappies: cloth_nappies,
      	                    food_provided: food, bus_service: bus, air_conditioning: air_conditioning, url: url )
    
    Address.create( addressable_id: p_new[:id], addressable_type: 'Provider',
    	street: street, suburb: suburb, state: state, post_code: post_code )

    Rolodex.create( rolodexable_id: p_new[:id], rolodexable_type: 'Provider',
      number_or_email: phone_number, kind: 'Office number', when_to_use: 'Anytime' )

    Rolodex.create( rolodexable_id: p_new[:id], rolodexable_type: 'Provider',
      number_or_email: email, kind: 'Email', when_to_use: 'Anytime' )

  end
  puts
end
#
# W R A P U P
#
#puts "\n\nLICENSEE: \t#{@licensee}"
puts "Addresses:    \t#{Address.count.to_s}"
puts "Certificates: \t#{Certificate.count.to_s}"
puts "Cert:         \t#{Cert.count.to_s}"
puts "Companies:    \t#{Company.count.to_s}"
puts "Rolodexes:    \t#{Rolodex.count.to_s}"
puts "People:       \t#{Person.count.to_s}"
puts "Providers:    \t#{Provider.count.to_s}"
puts "Roles:        \t#{Role.count.to_s}"
puts "Users:        \t#{AdminUser.count.to_s}"
puts "\n\n --Done"
