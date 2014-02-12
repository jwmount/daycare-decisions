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
  ['parent@parents.com', 'password', 3]
  ]

user_list.each do |email, password, role|  
  AdminUser.create!( email: email, password: password, password_confirmation: password, role_id: role)
  Rails::logger.info( "*-*-*-*-* Created user #{email}, pswd: #{password.slice(0..2)}, role: #{role}" )
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
