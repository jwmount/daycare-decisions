ActiveAdmin.register Person do


  filter :first_name
  filter :last_name
  filter :title
  filter :description
  filter :company

  scope :all, :default => true 
  scope :active do |people|
    people.where ({active: true})
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    #error_panel f

    f.inputs "Person Details" do

      f.input :first_name, 
              :hint         => AdminConstants::ADMIN_PERSON_FIRST_NAME_HINT,
              :placeholder  => AdminConstants::ADMIN_PERSON_FIRST_NAME_PLACEHOLDER

      f.input :last_name
      f.input :title
      f.input :company
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
        r.input :description
      end
    end

    f.inputs "Certs (Certificates Held)" do
      f.has_many :certs do |f|

        f.input :certificate,
                :collection => Certificate.where({:for_person => true}),
                :include_blank => false

        f.input :active

        f.input :expires_on, 
                :as => :date_picker,
                :hint => AdminConstants::ADMIN_CERT_EXPIRES_ON_HINT
      end
    end
    f.actions
  end #form


#
# P A R A M S
#

  permit_params :company_id, :first_name, :last_name, :title, :active,
      addresses_attributes: [:street, :suburn, :state, :post_code, :lat, :long, :_destroy ],
      rolodexes_attributes: [:number_or_email, :kind, :when_to_use, :description, :_destroy ],
      certs_attributes: [ :certificate_id, :serial_number, :expires_on, :active, :_destroy ]  

end
