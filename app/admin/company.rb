ActiveAdmin.register Company do

  menu parent: "Companies"
  
  permit_params :name, :active, :url, :descriptions
end
