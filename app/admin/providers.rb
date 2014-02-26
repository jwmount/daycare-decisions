ActiveAdmin.register Provider do


  scope :all, :default => true 
  scope :disposable_nappies do |providers|
    providers.where ({disposable_nappies: true})
  end
  scope :cloth_nappies do |providers|
    providers.where ({cloth_nappies: true})
  end
  # – Morning Tea, Lunch, Afternoon Tea MVP has Yes or some
  scope :food_provided do |providers|
    providers.where ({food_provided: true})
  end
  scope :air_conditioning do |providers|
    providers.where ({air_conditioning: true})
  end
  scope :bus_service do |providers|
    providers.where ({bus_service: true})
  end
  scope :extended_hours_for_kindys do |providers|
    providers.where ({extended_hours_for_kindys: true})
  end
  scope :online_waitlist do |providers|
    providers.where ({online_waitlist: true})
  end
  scope :online_waitlist do |providers|
    providers.where ({online_enrollment: true})
  end
  scope :security_access do |providers|
    providers.where ({online_enrollment: true})
  end
  scope :online_enrollment do |providers|
    providers.where ({security_access: true})
  end
  scope :additional_activities_included do |providers|
    providers.where ({additional_activities_included: true})
  end
  scope :excursions do |providers|
    providers.where ({excursions: true})
  end
  scope :guest_speakers do |providers|
    providers.where ({guest_speakers: true})
  end
  scope :outdoor_play_area do |providers|
    providers.where ({outdoor_play_area: true})
  end
  scope :real_grass do |providers|
    providers.where ({real_grass: true})
  end
  scope :technology do |providers|
    providers.where ({technology: true})
  end
  scope :sibling_has_priority do |providers|
    providers.where ({sibling_has_priority: true})
  end
  scope :vacancies do |providers|
    providers.where ({vacancies: true})
  end


  filter :company
  filter :name
  filter :care, :label => "Care Options"
  filter :NQS_rating
  filter :fee
  filter :waitlist_fee
  filter :description
  filter :url
  filter :language, :label => "Language Skills Training"
  filter :vacancies          # Vacancies 0-12mths 13-24mths 25-35 Months 36 Months – Pre-schoolOver Preschool age

  index do

    selectable_column

    column "Name (click for details)", :sortable => 'name' do |provider|
      render provider
      render provider.rolodexes# unless provider.rolodexes.empty?
      render provider.addresses# unless provider.addresses.empty?
    end

    column :company
    column :description
    column "Care Options" do |provider|
      provider.care
      end 
    column :NQS_rating
    column "Ages" do |provider| provider.age end
    column "Fee"  do |provider| number_to_currency(provider.fee) end
    column :waitlist_fee
    column :hours
    column :language

  end # indexø

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
              :collection    => care_options,
              :hint          => AdminConstants::ADMIN_PROVIDER_CARE_HINT,
              :placeholder   => AdminConstants::ADMIN_PROVIDER_CARE_PLACEHOLDER

      f.input :age

      f.input ('fee') { number_to_currency(provider.fee)}

      f.input :hours

      f.input :language,
              :collection    => language_options,
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
      f.input :waitlist_fee
      f.input :security_access
      f.input :additional_activities_included
      f.input :excursions
      f.input :guest_speakers
      f.input :outdoor_play_area
      f.input :real_grass
      f.input :technology
      f.input :sibling_has_priority
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
      row :care
      row :NQS_rating
      row ("Age Range") { provider.age }
      row ( 'fee' ) {number_to_currency(provider.fee)}
      row :hours
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
      row("On-line Enrollment") { status_tag (provider.online_enrollment ? "YES" : "No"), (provider.online_enrollment ? :ok : :error) }
      row :waitlist_fee
      row("Security Access") { status_tag (provider.security_access ? "YES" : "No"), (provider.security_access ? :ok : :error) }
      row("additional_activities_included") { status_tag (provider.additional_activities_included ? "YES" : "No"), (provider.additional_activities_included ? :ok : :error) }
      row("Excursions") { status_tag (provider.excursions ? "YES" : "No"), (provider.excursions ? :ok : :error) }
      row("Guest Speakers") { status_tag (provider.guest_speakers ? "YES" : "No"), (provider.guest_speakers ? :ok : :error) }
      row("Outdoor Play Area") { status_tag (provider.outdoor_play_area ? "YES" : "No"), (provider.outdoor_play_area ? :ok : :error) }
      row("Real Grass") { status_tag (provider.real_grass ? "YES" : "No"), (provider.real_grass ? :ok : :error) }
      row("Technology") { status_tag (provider.technology ? "YES" : "No"), (provider.technology ? :ok : :error) }
      row("Sibling Has Priority") { status_tag (provider.sibling_has_priority ? "YES" : "No"), (provider.sibling_has_priority ? :ok : :error) }
      row("Vacancies") { status_tag (provider.vacancies ? "YES" : "No"), (provider.vacancies ? :ok : :error) }
      end
    #active_admin_comments
  end #show

#
# My Providers Action Item - Display 'My' Prefered Providers
#
  action_item :only => [:index] do
    link_to 'My Provider List', admin_providers_path
  end

  # My Prefered Provider List
  member_action :mylist, :method => :get do
  end

#
# batch actions
#
  # add selected providers to user's list of prefered care providers
  batch_action :add_to_list, confirm: "Add selected providers to your prefered provider list??" do |selection|
    guardian = Guardian.first
    Provider.find(selection).each do |provider|
      GuardiansProviders.create!(:guardian_id=>guardian.id, :provider_id=>provider.id)
    end
    redirect_to admin_providers_path
  end

  # remove_provider -- remove provider from user's list of prefered providers
  batch_action :clear_list, confirm: "Clear all providers from your list of selected providers?" do |selection|
    guardian = Guardian.first
    #Provider.find(selection).each do |provider|
      guardian.providers.delete_all
     # assoc_gp = GuardiansProviders.find(:guardian_id=>guardian.id, :provider_id=>provider.id)
     # assoc_qp.destroy
    #end
    redirect_to admin_providers_path
  end
 

#
# P E R M I T  P A R A M S
#

  permit_params :id, :company_id, :name, :care, :description, :disposable_nappies, :cloth_nappies,
    :NQS_rating, :language, :url, :food_provided, :air_conditioning,
    :bus_service, :extended_hours_for_kindys, :online_waitlist, :online_enrollment, :security_access,
    :additional_activities_included, :excursions, :guest_speakers, :outdoor_play_area, :real_grass,
    :technology, :sibling_has_priority, :vacancies,
      addresses_attributes: [:id, :street, :suburb, :state, :post_code, :lat, :long, :_destroy],
      rolodexes_attributes: [:id, :number_or_email, :kind, :when_to_use, :description, :_destroy],
      certs_attributes: [ :id, :certificate_id, :serial_number, :expires_on, :active, :_destroy ]

end
