ActiveAdmin.register Certificate do

  menu parent: "Compliance"

  scope :all, :default => true 
  scope :people do |certificates|
    certificates.where ({for_person: true})
  end
  scope :companies do |certificates|
    certificates.where ({for_company: true})
  end

  index do
    column :name , :sortable => 'name' do |certificate|
      link_to certificate.name, admin_certificate_path(certificate)
    end
    column :description
    column :for_person do |certificate|
      status_tag (certificate.for_person ? "YES" : "No"), (certificate.for_person ? :ok : :error)
    end    
    column :for_provider do |certificate|
      status_tag (certificate.for_provider ? 'YES' : 'No'), (certificate.for_provider ? :ok : :error)
    end    

  end
  
  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs "Certificate" do
      f.input :name,          
              :required => true,
              :placeholder => "Name"
      f.input :description, 
              :placeholder => "Description"
      f.input :for_provider
      f.input :for_person

    end
    f.actions
  end
       
  show :title => 'Certificate Details' do
    h3 certificate.name
    panel "Certificate Details" do
      attributes_table_for certificate do
        row("Name") { certificate.name }
        row("Description") {certificate.description}
        row("For Person") { status_tag (certificate.for_person ? "YES" : "No"), (certificate.for_person ? :ok : :error) }
        row("For Provider") { status_tag (certificate.for_company ? "YES" : "No"), (certificate.for_company ? :ok : :error) }
      end
    end
    active_admin_comments
  end          

#
# P A R A M E T E R  L I S T
#  
    permit_params :name, :active, :description, :for_person, :for_company, :for_provider,
      certs_attributes: [:certificate_id, :expires_on, :serial_number, :active]

end

