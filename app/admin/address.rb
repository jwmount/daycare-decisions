ActiveAdmin.register Address do

  
  permit_params :street,  :suburb, :state, :post_code, :lat, :long, :utf8
  
end
