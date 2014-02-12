ActiveAdmin.register Person do

  permit_params :company_id, :first_name, :last_name, :title, :active  

end
