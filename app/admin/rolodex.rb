ActiveAdmin.register Rolodex do

  menu parent: "Admin"

  actions :all, :except => :new

  # filter :number_or_email
  filter :kind
  filter :when_to_use
  filter :description

  index do

    selectable_column

    column "Name (click for details)", :sortable => 'name' do |item|
      facility = "#{item.rolodexable_type}".constantize.where(id: item.rolodexable_id)
      render facility
    end

    column :kind
    column :when_to_use
    column :description
    column :created_at
    column :updated_at

  end
#
# 
# P A R A M S
#
  permit_params :number_or_email, :kind,  :when_to_use,  :description
  
end
