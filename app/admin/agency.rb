ActiveAdmin.register Agency do

  
  menu parent: "Companies"

  permit_params :name, :description, :type

end
