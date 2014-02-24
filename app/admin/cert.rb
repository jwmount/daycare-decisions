ActiveAdmin.register Cert do

  menu parent: "Compliance"

  actions :all, :except => :new


  scope :all, :default => true 
  scope :active do |certs|
    certs.where ({for_person: true})
  end
  scope :inactive do |certs|
    certs.where ({for_person: false})
  end
  scope :for_company do |certs|
  	certs.certificate.where ({for_company: true})
  end
  scope :for_person do |certs|
  	certs.certificate.where ({for_person: true})
  end
  scope :for_provider do |certs|
  	certs.certificate.where ({for_provider: true})
  end
  
  index do
    column :name , :sortable => 'name' do |cert|
      link_to cert.certificate.name, admin_cert_path(cert)
    end
    column :description do |cert|
    	cert.certificate.description
    end
    column :for_person do |cert|
      status_tag (cert.for_person ? "YES" : "No"), (cert.for_person ? :ok : :error)
    end    
    column :for_provider do |cert|
      status_tag (cert.for_provider ? 'YES' : 'No'), (cert.for_provider ? :ok : :error)
    end    
    column :active do |cert|
      status_tag (cert.active ? "YES" : "No"), (cert.active ? :ok : :error)      
    end    
  end
  
  form do |f|
    error_panel f

    f.inputs "Details" do
      if Certificate.alphabetically.all.empty?
        'No certificates have been added yet.'
      else
        f.input :certificate, :as => :select, 
                              :collection => Certificate.alphabetically.all.map {|u| [u.name, u.id]}, 
                              :include_blank => false
      end
      
      f.input :serial_number, 
              :hint => "ID number, license number or value that makes this document unique."

      f.input :expires_on, 
              :as => :date_picker,              
              :hint => "When the certificate or license expires.  Leave blank if document or status is permanent."  

      f.input :active do |cert|
        status_tag (cert.active ? "YES" : "No"), (cert.active ? :ok : :error)            
      end        
    end
    #f.buttons
    f.actions
  end
       
  show :title => 'Certificate Details' do
    h3 certificate.name
    panel "Certificate Details" do
      attributes_table_for certificate do
        row("Name") { certificate.name }
        row("Active") { status_tag (certificate.active ? "YES" : "No"), (certificate.active ? :ok : :error) }
        row("Description") {certificate.description}
        row("For Person") { status_tag (certificate.for_person ? "YES" : "No"), (certificate.for_person ? :ok : :error) }
        row("For Provider") { status_tag (certificate.for_company ? "YES" : "No"), (certificate.for_company ? :ok : :error) }
      end
    end
    active_admin_comments
  end          

  permit_params :expires_on, :active, :certificate_id, :certifiable_type, :serial_number  
end
