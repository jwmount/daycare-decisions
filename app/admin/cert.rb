ActiveAdmin.register Cert do

  menu parent: "Compliance"

  permit_params :expires_on, :active
  
end
