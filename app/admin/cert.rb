ActiveAdmin.register Cert do

  menu parent: "Compliance"

  actions :all, :except => :new

  permit_params :expires_on, :active, :certificate_id, :certifiable_type, :serial_number  
end
