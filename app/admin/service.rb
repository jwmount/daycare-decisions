ActiveAdmin.register Service do

 index do

    selectable_column

    column "Name (click for details)", :sortable => 'name' do |service|
      render service
    end

    column :description
  end
  
  permit_params :name, :description  

end
