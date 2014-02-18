ActiveAdmin.register Provider do

  menu parent: "Companies"

  index do

    selectable_column

    column "Name (click for details)", :sortable => 'name' do |provider|
      render provider
      if provider.rolodexes.count > 0
        @rolodexes = provider.rolodexes
        render @rolodexes
      end
      if provider.certs.count > 0
        @certs = provider.certs
        render @certs
      end
    end

    column :company
    column :description
    column :care
    column :NQS_rating
    column :language
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    #error_panel f

    f.inputs "Provider Details" do

      f.input :name, 
              :hint         => AdminConstants::ADMIN_PROVIDER_NAME_HINT,
              :placeholder  => AdminConstants::ADMIN_PROVIDER_NAME_PLACEHOLDER

      f.input :company
      
      f.input :description

      f.input :NQS_rating,
              :hint         => AdminConstants::ADMIN_PROVIDER_NQS_RATING_HINT,
              :placeholder  => AdminConstants::ADMIN_PROVIDER_NQS_RATING_PLACEHOLDER
      
      f.input :care,
              :hint          => AdminConstants::ADMIN_PROVIDER_CARE_HINT,
              :placeholder   => AdminConstants::ADMIN_PROVIDER_CARE_PLACEHOLDER

      f.input :language,
              :label         => AdminConstants::ADMIN_PROVIDER_LANGUAGE_LABEL,
              :hint          => AdminConstants::ADMIN_PROVIDER_LANGUAGE_HINT,
              :placeholder   => AdminConstants::ADMIN_PROVIDER_LANGUAGE_PLACEHOLDER

      f.input :url
      f.input :food_provided
      f.input :disposable_nappies
      f.input :cloth_nappies
      f.input :air_conditioning
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
        r.input :description
      end
    end

    f.inputs "Certs (Certificates)" do
      f.has_many :certs do |f|

        f.input :certificate,
                :collection => Certificate.where({:for_provider => true}),
                :include_blank => false

        f.input :active

        f.input :expires_on, 
                :as => :date_picker,
                :hint => AdminConstants::ADMIN_CERT_EXPIRES_ON_HINT
      end
    end

    f.actions
  end #form

  show :title => :name do
    attributes_table do
      row :name
      row :company
      row ("Address") { render provider.addresses}
      row ("Certifications") { render provider.certs}
      row ("Rolodex") {render provider.rolodexes}
      row ("Web Site") { link_to "#{provider.url}", href="http://#{provider.url}", target: '_blank' }
      row :description
      row("Food Provided") { status_tag (provider.food_provided ? "YES" : "No"), (provider.food_provided ? :ok : :error) }
      row("Disposable Nappies") { status_tag (provider.disposable_nappies ? "YES" : "No"), (provider.disposable_nappies ? :ok : :error) }
      row("Cloth Nappies") { status_tag (provider.cloth_nappies ? "YES" : "No"), (provider.cloth_nappies ? :ok : :error) }
      row("Air Conditioning") { status_tag (provider.air_conditioning ? "YES" : "No"), (provider.air_conditioning ? :ok : :error) }
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
      row("Vacancies") { status_tag (provider.vacancies ? "YES" : "No"), (provider.vacancies ? :ok : :error) }
      end
    #active_admin_comments
  end #show

#
# P E R M I T  P A R A M S
#

  permit_params :company_id, :name, :care, :description, :NQS_rating, :language, :url, :food_provided, :air_conditioned,
    :bus_service, :extended_hours_for_kindys, :online_waitlist, :online_enrollment, :security_access,
    :additional_activities_included, :excursions, :guest_speakers, :outdoor_play_area, :real_grass,
    :technology, :vacancies,
      addresses_attributes: [:street, :suburn, :state, :post_code, :lat, :long, :_destroy],
      rolodexes_attributes: [:number_or_email, :kind, :when_to_use, :description],
      certs_attributes: [ :certificate_id, :serial_number, :expires_on, :active ]

end
