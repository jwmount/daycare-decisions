ActiveAdmin.register Company do

  menu parent: "Companies"

  filter :addresses
  
  permit_params :name, :active, :url, :descriptions
end
