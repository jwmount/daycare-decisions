require 'csv'    

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
roles_list = %w[ admin management guardian superadmin ]
roles_list.each do |role|
  Role.create!(name: role)
end

# Create users (roles not implemented yet, MUST be chosen from roles_list)
user_list = [
  ['john@venuesoftware.com', 'password', 4],
  ['rebecca@daycaredecisions.com', 'password', 1],
  ['rebecca@daycaredecisions.com.au', 'password', 2],
  ['guardian@iLab.com.au', 'password', 3],
  ['tgodino@icloud.com', 'password', 4]
  ]

user_list.each do |email, password, role|  
  user = AdminUser.where( email: email )
  if user[0] == nil
  	AdminUser.create( email: email, password: password, password_confirmation: password, role_id: role)
  end
  Rails::logger.info( "*-*-*-*-* Created user #{email}, pswd: #{password.slice(0..2)}, role: #{role}" )
end

puts
puts
#
# Agencies
#
csv_text = File.read('public/agencies.csv')
csv = CSV.parse(csv_text, :headers => true)
csv.each do |row|
# Name,Street_Address,Locality,State,Post Code,Phone Number,Email,Web Address
  agency             = row.to_hash
  name               = agency['Name']
  jurisdiction       = agency['Jurisdiction']
  url                = agency['Web Address'].to_s.gsub("http://", "")

  street_address     = agency['Street_Address']
  locality           = agency['Locality']
  state              = agency['State']
  post_code          = agency['Post Code']

  phone_number       = agency['Phone Number']
  email              = agency['Email']
  
  a_new = Agency.where( name: name )
  if a_new[0] == nil
    a_new = Agency.create!( name: name, 
                            jurisdiction: jurisdiction,
                            url: url
                            )
  end
  puts a_new.name
end

#
# CERTIFICATES
#
# http://www.acecqa.gov.au/Qualifications.aspx
#
personal_certificates_list = [
    'Supervisor Certificate',
    'First Aid Certificate',
    'Blue Card',
    'Certificate 4 in Out of School Hours Care'
  ]
provider_certificates_list = [
    'Approved to provide Long Day Care Certificate',
    'Approved to provide Home Care Certificate',
    'In & Out of School Hours Care Certificate'
  ]

personal_certificates_list.each do |name|
  Certificate.create!(name: name, for_person: true)
end
provider_certificates_list.each do |name|
  Certificate.create!(name: name, for_provider: true)
end
personal_certificates = Certificate.where(:for_person   => true)
personal_certificates.each {|pc| puts pc.name }
provider_certificates = Certificate.where(:for_provider => true)
provider_certificates.each {|pc| puts pc.name }

puts
puts

# END OF EXPERIMENT -- Load qld_database class

#
# W R A P U P
#
#puts "\n\nLICENSEE: \t#{@licensee}"
puts "Addresses:    \t#{Address.count.to_s}"
puts "Agencies:     \t#{Agency.count.to_s}"
puts "Certificates: \t#{Certificate.count.to_s}"
puts "Cert:         \t#{Cert.count.to_s}"
puts "Companies:    \t#{Company.count.to_s}"
puts "Guardians:    \t#{Guardian.count.to_s}"
puts "Rolodexes:    \t#{Rolodex.count.to_s}"
puts "People:       \t#{Person.count.to_s}"
puts "Providers:    \t#{Provider.count.to_s}"
puts "Roles:        \t#{Role.count.to_s}"
puts "Services:     \t#{Service.count.to_s}"
puts "Users:        \t#{AdminUser.count.to_s}"
puts "Waitlist Applications: \t#{WaitlistApplication.count.to_s}"
puts "\n --Done\n\n"
puts " --Next Step:  Load providers with \t\t$ rake csv:load_providers.\n\n"
puts "               Load 2000 test providers with \t$ rake csv:load_test.\n\n"
