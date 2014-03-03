ActiveAdmin.register Company do


  scope :all, :default => true 
  scope :active do |companies|
    companies.where ({active: true})
  end

  filter :company
  filter :name
  filter :description

  index do

    selectable_column

    column "Name (click for details)", :sortable => 'name' do |company|
      render company
      render company.rolodexes
      render company.addresses
    end

    column "Company's Providers", :sortable => 'name' do |company|
      if company.providers.count > 0
      	@providers = company.providers
      	render @providers
      end
    end

    column :active
    column :description

  end #index

  form do |f|
    f.semantic_errors *f.object.errors.keys
    #error_panel f

    f.inputs "Company Details" do

      f.input :name, 
              :hint         => AdminConstants::ADMIN_PROVIDER_NAME_HINT,
              :placeholder  => AdminConstants::ADMIN_PROVIDER_NAME_PLACEHOLDER
      f.input :active
      f.input :url
      f.input :description

    end

    f.inputs "Addresses" do
      f.has_many :addresses do |a|
          a.input :street
          a.input :suburb
          a.input :state
          a.input :post_code
          a.input :lat
          a.input :long
      end
    end

    f.inputs "Rolodexes" do
      f.has_many :rolodexes do |r|
        r.input :number_or_email
        r.input :kind
        r.input :when_to_use
      end
    end

    f.inputs "Certs (Certificates)" do
      f.has_many :certs do |f|

        f.input :certificate,
                :collection => Certificate.where({:for_provider => true}),
                :include_blank => false

        f.input :active

        f.input :expires_on, 
                :as => :date_picker,
                :hint => AdminConstants::ADMIN_CERT_EXPIRES_ON_HINT
      end
    end
    f.actions
  end

show :title => :name do
    attributes_table do
      row :name
      row ("Web Site") { link_to "#{company.url}", href="http://#{company.url}", target: '_blank' }
      row :description
      row("Active") { status_tag (company.active ? "YES" : "No"), (company.active ? :ok : :error) }
      row ("Address") { render company.addresses}
      row ("Certifications") { company.certs}
      row ("Rolodex") {render company.rolodexes}
  end
end
  
#
# P A R A M S
# 

  permit_params :name, :active, :url, :description,
      addresses_attributes: [:street, :suburb, :state, :post_code, :lat, :long, :_destroy],
      rolodexes_attributes: [:number_or_email, :kind, :when_to_use, :description, :_destroy],
      certs_attributes: [ :certificate_id, :serial_number, :expires_on, :active, :_destroy ]


end
