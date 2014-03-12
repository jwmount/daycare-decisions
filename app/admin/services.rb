ActiveAdmin.register Service do

  actions :all, :except => :new

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

=begin
  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs "Service Details" do
  
      f.input :name, 
              :hint         => AdminConstants::ADMIN_SERVICE_NAME_HINT,
              :placeholder  => AdminConstants::ADMIN_SERVICE_NAME_PLACEHOLDER

      f.input :description,
              :hint         => AdminConstants::ADMIN_SERVICE_DESCRIPTION_HINT,
              :placeholder  => AdminConstants::ADMIN_SERVICE_DESCRIPTION_PLACEHOLDER

      f.input :fee,
              :hint         => AdminConstants::ADMIN_SERVICE_FEE_HINT,
              :placeholder  => AdminConstants::ADMIN_SERVICE_FEE_PLACEHOLDER

      f.input :basis,
              :hint         => AdminConstants::ADMIN_SERVICE_BASIS_HINT,
              :placeholder  => AdminConstants::ADMIN_SERVICE_BASIS_PLACEHOLDER

    end
    f.actions
  end
=end
#
# P A R A M E T E R  L I S T
#
  permit_params :name, :description, :fee, :basis

end
