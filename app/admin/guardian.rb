ActiveAdmin.register Guardian do

  filter :name

  index do

    selectable_column

    column "Family Name (click for details)", :sortable => 'name' do |guardian|
      render guardian
      render guardian.rolodexes unless guardian.rolodexes.empty?
      render guardian.addresses unless guardian.addresses.empty?
    end

    column "My Providers" do |guardian|
      render guardian.providers
    end

=begin
    column "Provider Waitlist" do |guardian|
      render guardian.waitlist_applications unless guardian.waitlist_applications.empty?
    end
    column :waitlist_applications do |guardian|
      if guardian.waitlist_applications.count > 0
        link_to "Waitlist Application (#{guardian.waitlist_applications.count.to_s})", admin_guardian_waitlist_applications_path( guardian )
      else
        link_to "New Application", new_admin_guardian_waitlist_applications_path( guardian )
      end
    end
=end

  end #index


  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs "Guardian Details" do
      f.input :first_name,
              :hint         => AdminConstants::ADMIN_GUARDIAN_FIRST_NAME_HINT,
              :placeholder  => AdminConstants::ADMIN_GUARDIAN_FIRST_NAME_PLACEHOLDER

      f.input :family_name, 
              :hint         => AdminConstants::ADMIN_GUARDIAN_SURNAME_HINT,
              :placeholder  => AdminConstants::ADMIN_GUARDIAN_SURNAME_PLACEHOLDER
    end
  
    f.inputs "Addresses" do
      f.has_many :addresses do |a|
          a.input :street_address
          a.input :locality
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

#
# My Providers Action Item - Display 'My' Prefered Providers
#
=begin
  action_item :only => [:index] do
    link_to 'My Waitlist Application', admin_guardian_waitlist_applications_path( guardian )
  end

  # My Prefered Provider List
  member_action :mylist, :method => :get do
    @waitlist_application = guardian.waitlist_application
    redirect_to admin_waitlist_applications_path
  end
=end

  permit_params :first_name, :family_name,
      addresses_attributes: [:id, :street_address, :locality, :state, :post_code, :lat, :long, :_destroy],
      rolodexes_attributes: [:id, :number_or_email, :kind, :when_to_use, :description, :_destroy]

end
