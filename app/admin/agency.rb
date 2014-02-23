ActiveAdmin.register Agency do

 index do

    selectable_column

    column "Agency Name (click for details)", :sortable => 'name' do |agency|
      render agency
    end

    column :description
    column :jurisdiction
    column :url
    
  
  end #index

  permit_params :name, :description, :jurisdiction, :url


end
