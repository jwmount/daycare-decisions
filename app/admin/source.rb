ActiveAdmin.register Source do

  actions :all, :except => :new

  index do

    selectable_column

    column :name
    column :sourceable_type
    column :sourceable_id
    column :description
    column :updated_at
    column :created_at

    
  end
  
  permit_params :name, :description
  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  
end
