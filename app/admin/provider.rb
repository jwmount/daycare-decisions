ActiveAdmin.register Provider do


 index do

    selectable_column

    column "Name (click for details)", :sortable => 'name' do |provider|
      render provider
=begin
      if company.certs.count > 0
        @certs = company.certs
        render @certs
      end
=end
    end

    column :address
    column :type_of_care
    column :NQS_rating
    column :languages
    column :url
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    #error_panel f

    f.inputs "Provider Details" do

      f.input :name, 
              :hint         => AdminConstants::ADMIN_COMPANY_NAME_HINT,
              :placeholder  => AdminConstants::ADMIN_COMPANY_NAME_PLACEHOLDER
    end

    f.inputs "Addresses" do
      f.has_many :addresses do |a|
          a.input :street_address
          a.input :city
          a.input :state
          a.input :post_code
          a.input :map_reference
      end
    end
  end #form

#
# P E R M I T  P A R A M S
#

  permit_params :name, :type_of_care, :NQS_rating, :languages, :url

end
