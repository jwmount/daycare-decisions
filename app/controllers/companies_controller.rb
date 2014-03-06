class CompaniesController < InheritedResources::Base

#
# P A R A M S
# 

  permit_params :name, :active, :url, :description,
      addresses_attributes: [:street_address, :locality, :state, :post_code, :lat, :long, :_destroy],
      rolodexes_attributes: [:number_or_email, :kind, :when_to_use, :description, :_destroy],
      certs_attributes: [ :certificate_id, :serial_number, :expires_on, :active, :_destroy ]

end
