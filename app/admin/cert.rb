ActiveAdmin.register Cert do

  menu parent: "Compliance"

  permit_params :expires_on, :active, :certificate_id, :certifiable_type, :serial_number  
end
