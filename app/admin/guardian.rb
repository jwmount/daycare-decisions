ActiveAdmin.register Guardian do

  index do

    selectable_column

    column "Family Name (click for details)", :sortable => 'name' do |guardian|
      render guardian
      render guardian.rolodexes unless guardian.rolodexes.empty?
      render guardian.addresses unless guardian.addresses.empty?
    end

    column "Provider Waitlists" do |guardian|
      render guardian.applications unless guardian.applications.empty?
    end

  end #index


  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs "Guardian Details" do

      f.input :family_name, 
              :hint         => AdminConstants::ADMIN_GUARDIAN_SURNAME_HINT,
              :placeholder  => AdminConstants::ADMIN_GUARDIAN_SURNAME_PLACEHOLDER
    end
  
    f.inputs "Addresses" do
      f.has_many :addresses do |a|
          a.input :street
          a.input :suburb
          a.input :state
          a.input :post_code
          a.input :lat
          a.input :long
      end
    end

    f.inputs "Rolodexes" do
      f.has_many :rolodexes do |r|
        r.input :number_or_email
        r.input :kind
        r.input :when_to_use
      end
    end
    f.actions
  end #form


  permit_params :first_name, :family_name,
      addresses_attributes: [:id, :street, :suburb, :state, :post_code, :lat, :long, :_destroy],
      rolodexes_attributes: [:id, :number_or_email, :kind, :when_to_use, :description, :_destroy]

end
