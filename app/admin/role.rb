ActiveAdmin.register Role do

  menu parent: "Admin"
  
  permit_params :id, :name, :utf8
  
end
