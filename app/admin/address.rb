ActiveAdmin.register Address do

  menu parent: "Admin"
  
  permit_params :street,  :suburb, :state, :post_code, :lat, :long, :utf8
  
end
