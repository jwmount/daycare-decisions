ActiveAdmin.register Requirement do

  menu parent: "Compliance"


  permit_params :description, :for_person

end
