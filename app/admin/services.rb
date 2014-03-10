ActiveAdmin.register Service do

  #menu false

  index do

    selectable_column

    column "Service Offered (click for details)", :sortable => 'name' do |service|
      render service
    end

    column "Provider" do |service|
    	render service.serviceable
    end

    column :description

    column :fee

    column :basis
    
  end
  
  permit_params :name, :description, :fee, :basis

end
