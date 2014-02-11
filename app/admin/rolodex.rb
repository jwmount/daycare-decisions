ActiveAdmin.register Rolodex do

  menu parent: "Admin"
 
  permit_params :number_or_email, :kind,  :when_to_use,  :description
  
end
