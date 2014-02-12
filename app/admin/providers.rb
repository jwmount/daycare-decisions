ActiveAdmin.register Provider do

  menu parent: "Companies"

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

    column "Address" do |provider|
      @address = Address.where("addressable_id = ? AND addressable_type = ?", self.id, 'Provider').limit(1)
      render @address 
    end
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
      f.input :type_of_care
      f.input :NQS_rating
      f.input :languages
      f.input :url

    end


    f.inputs "Addresses" do
      f.has_many :addresses do |a|
          a.input :street
          a.input :city
          a.input :state
          a.input :post_code
          a.input :lat
          a.input :long
      end
    end

    f.inputs "Rolodexes" do
      f.has_many :rolodexes do|r|
        r.input :number_or_email
        r.input :kind
        r.input :when_to_use
        r.input :description
      end
    end

    f.actions
  end #form

  show :title => :name do
    attributes_table do
      row :name
      row ("Rollodex") {render provider.rolodexes}
      row ("Web Site") { link_to "#{provider.url}", href="http://#{provider.url}", target: '_blank' }
      row ("Address") { render provider.addresses}
      row ("Certifications") { render provider.certs}
      end
    #active_admin_comments
  end #show

#
# P E R M I T  P A R A M S
#

  permit_params :name, :type_of_care, :NQS_rating, :languages, :url,
    addresses_attributes: [:street, :city, :state, :post_code, :lat, :long, :_destroy],
    rolodexes_attributes: [:number_or_email, :kind, :when_to_use, :description]

end
