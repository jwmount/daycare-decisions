ActiveAdmin.register Provider do

  menu parent: "Companies"

 index do

    selectable_column

    column "Name (click for details)", :sortable => 'name' do |provider|
      render provider
=begin
      if company.certs.count > 0
        @certs = company.certs
        render @certs
      end
=end
    end

    column "Address" do |provider|
      @address = Address.where("addressable_id = ? AND addressable_type = ?", self.id, 'Provider').limit(1)
      render @address 
    end
    column :type_of_care
    column :NQS_rating
    column :languages
    column :url
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    #error_panel f

    f.inputs "Provider Details" do

      f.input :name, 
              :hint         => AdminConstants::ADMIN_COMPANY_NAME_HINT,
              :placeholder  => AdminConstants::ADMIN_COMPANY_NAME_PLACEHOLDER
      f.input :type_of_care
      f.input :NQS_rating
      f.input :languages
      f.input :url
      f.input :food_provided
      f.input :air_conditioned
      f.input :bus_service
      f.input :extended_hours_for_kindys
      f.input :online_waitlist
      f.input :online_enrollment
      f.input :security_access
      f.input :additional_activities_included
      f.input :excursions
      f.input :guest_speakers
      f.input :outdoor_play_area
      f.input :real_grass
      f.input :technology
      f.input :vacancies
    end


    f.inputs "Addresses" do
      f.has_many :addresses do |a|
          a.input :street
          a.input :city
          a.input :state
          a.input :post_code
          a.input :lat
          a.input :long
      end
    end

    f.inputs "Rolodexes" do
      f.has_many :rolodexes do|r|
        r.input :number_or_email
        r.input :kind
        r.input :when_to_use
        r.input :description
      end
    end

    f.actions
  end #form

  show :title => :name do
    attributes_table do
      row :name
      row ("Rollodex") {render provider.rolodexes}
      row ("Web Site") { link_to "#{provider.url}", href="http://#{provider.url}", target: '_blank' }
      row("Food Provided") { status_tag (provider.food_provided ? "YES" : "No"), (provider.food_provided ? :ok : :error) }
      row("Air Conditioned") { status_tag (provider.air_conditioned ? "YES" : "No"), (provider.air_conditioned ? :ok : :error) }
      row("Bus Service") { status_tag (provider.bus_service ? "YES" : "No"), (provider.bus_service ? :ok : :error) }
      row("Extended Hours for Kindys") { status_tag (provider.extended_hours_for_kindys ? "YES" : "No"), 
        (provider.extended_hours_for_kindys ? :ok : :error) }
      row("On-line Waitlist") { status_tag (provider.online_waitlist ? "YES" : "No"), (provider.online_waitlist ? :ok : :error) }
      row("On-line enrollment") { status_tag (provider.online_enrollment ? "YES" : "No"), (provider.online_enrollment ? :ok : :error) }
      row("Security Access") { status_tag (provider.security_access ? "YES" : "No"), (provider.security_access ? :ok : :error) }
      row("additional_activities_included") { status_tag (provider.additional_activities_included ? "YES" : "No"), (provider.additional_activities_included ? :ok : :error) }
      row("Excursions") { status_tag (provider.excursions ? "YES" : "No"), (provider.excursions ? :ok : :error) }
      row("Guest Speakers") { status_tag (provider.guest_speakers ? "YES" : "No"), (provider.guest_speakers ? :ok : :error) }
      row("outdoor_play_area") { status_tag (provider.outdoor_play_area ? "YES" : "No"), (provider.outdoor_play_area ? :ok : :error) }
      row("Real Grass") { status_tag (provider.real_grass ? "YES" : "No"), (provider.real_grass ? :ok : :error) }
      row("Technology") { status_tag (provider.technology ? "YES" : "No"), (provider.technology ? :ok : :error) }
      row("Security Access") { status_tag (provider.security_access ? "YES" : "No"), (provider.security_access ? :ok : :error) }
      row("Security Access") { status_tag (provider.security_access ? "YES" : "No"), (provider.security_access ? :ok : :error) }
      row("Vacancies") { status_tag (provider.vacancies ? "YES" : "No"), (provider.vacancies ? :ok : :error) }

      row ("Address") { render provider.addresses}
      row ("Certifications") { render provider.certs}
      end
    #active_admin_comments
  end #show

#
# P E R M I T  P A R A M S
#

  permit_params :name, :type_of_care, :NQS_rating, :languages, :url, :food_provided, :air_conditioned,
    :bus_service, :extended_hours_for_kindys, :online_waitlist, :online_enrollment, :security_access,
    :additional_activities_included, :excursions, :guest_speakers, :outdoor_play_area, :real_grass,
    :technology, :vacancies,
    addresses_attributes: [:street, :city, :state, :post_code, :lat, :long, :_destroy],
    rolodexes_attributes: [:number_or_email, :kind, :when_to_use, :description]

end
