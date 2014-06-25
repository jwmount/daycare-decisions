# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

#ENV['VERSION'] = "v0.1.134-mySql. &copy Copyright Daycare Decisions, DBA, 2014."
ENV['VERSION'] = "v0.2.6. &copy Copyright Daycare Decisions, DBA, 2014."

# Google Client side Geocoding
# https://maps.googleapis.com/maps/api/geocode/json?address=5+St+Kilda+Ave.,+Broad+Beach,QLD,Postal_code+4218,Australia,&sensor=false&key=AIzaSyDVUWaiCEzOlXjYsSCJaKlAOwKcnqDA7Cs
ENV['google_api_key'] = "AIzaSyDVUWaiCEzOlXjYsSCJaKlAOwKcnqDA7Cs"