ActiveAdmin.register Role do

  menu parent: "Admin"
  
  permit_params :name  
  
end
