ActiveAdmin.register Address do

  actions :all, :except => :new


  index do

    selectable_column

    column "Name (click for details)" do |address|
      facility = "#{address.addressable_type}".constantize.where(id: address.addressable_id)
      render facility
    end

    column "Kind of Facility" do |address|
    	address.addressable_type
    end
    column :street_address
    column :locality
    column :state
    column :post_code
    column :lat
    column :long
    column :created_at
    column :updated_at

  end
#
# P A R A M S
#  

  permit_params :street_address,  :locality, :state, :post_code, :lat, :long, :utf8
  
end
