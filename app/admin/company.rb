ActiveAdmin.register Company do

  menu parent: "Companies"

  scope :all, :default => true 
  scope :active do |companies|
    companies.where ({active: true})
  end

  filter :name
  filter :description

  index do

    selectable_column

    column "Name (click for details)", :sortable => 'name' do |company|
      render company
      if company.rolodexes.count > 0
        @rolodexes = company.rolodexes
        render @rolodexes
      end
      if company.certs.count > 0
        @certs = company.certs
        render @certs
      end
    end

    column "Company's Providers", :sortable => 'name' do |company|
      if company.providers.count > 0
      	@providers = company.providers
      	render @providers
      end
    end

    column :ActiveAdmin
    column :description

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

  permit_params :name, :active, :url, :description

end
