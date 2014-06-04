ActiveAdmin.register Provider do

  # scopes can be logical ands, for example this works:
  #  providers.where ({waitlist_reimbursed: true, cloth_nappies: true})
  # Question is, how to show this?

  scope :all, :default => true 
  scope :additional_activities do |providers|
    providers.where ({additional_activities: true})
  end
  scope :air_conditioning do |providers|
    providers.where ({air_conditioning: true})
  end
  scope :bus_service do |providers|
    providers.where ({bus_service: true})
  end
  scope :cloth_nappies do |providers|
    providers.where ({cloth_nappies: true})
  end
  scope :disability_friendly do |providers|
    providers.where ({disability_friendly: true})
  end
  scope :disposable_nappies do |providers|
    providers.where ({disposable_nappies: true})
  end
  # – Morning Tea, Lunch, Afternoon Tea MVP has Yes or some
  scope :excursions do |providers|
    providers.where ({excursions: true})
  end
  scope :extended_hours_for_kindys do |providers|
    providers.where ({extended_hours_for_kindys: true})
  end
  scope :food_provided do |providers|
    providers.where ({food_provided: true})
  end
  scope :guest_speakers do |providers|
    providers.where ({guest_speakers: true})
  end
  scope :kindergarten do |providers|
    providers.where ({kindergarten: true})
  end

  scope :languages do |providers|
    providers.where ({languages: true})
  end

  scope :online_enrollment do |providers|
    providers.where ({online_enrollment: true})
  end
  scope :outdoor_play_area do |providers|
    providers.where ({outdoor_play_area: true})
  end
  scope :real_grass do |providers|
    providers.where ({real_grass: true})
  end
  scope :secure_access do |providers|
    providers.where ({secure_access: true})
  end
  scope :sibling_priority do |providers|
    providers.where ({sibling_priority: true})
  end
  scope :technology do |providers|
    providers.where ({technology: true})
  end
  
  scope :vacancies do |providers|
    providers.where ({vacancies: true})
  end
  scope :vaccinations_compulsory do |providers| 
    providers.where( {vaccinations_compulsory: true } )
  end

  scope :waitlist_online do |providers|
    providers.where ({waitlist_online: true})
  end

  scope :waitlist_reimbursed do |providers|
    providers.where ({waitlist_reimbursed: true})
  end


  filter :additional_activities_list, :label => AdminConstants::ADMIN_PROVIDER_ADDITIONAL_ACTIVITIES_FILTER
  filter :address
  filter :company, :label => AdminConstants::ADMIN_PROVIDER_COMPANY_FILTER
  filter :name
  filter :care_offered, :label => AdminConstants::ADMIN_PROVIDER_CARE_OFFERED_FILTER
  filter :description
  filter :disabilities_list
  filter :fee, :label => AdminConstants::ADMIN_PROVIDER_FEE_FILTER
  filter :languages_list, :label => AdminConstants::ADMIN_PROVIDER_LANGUAGES_FILTER
  filter :NQS_rating, :label => AdminConstants::ADMIN_PROVIDER_OVERALLL_RATING_FILTER
  filter :technology_list, :label => AdminConstants::ADMIN_PROVIDER_TECHNOLOGIES_AVAILABLE_FILTER
  filter :vacancies_list, :label => AdminConstants::ADMIN_PROVIDER_VACANCY_LIST          # Vacancies 0-12mths 13-24mths 25-35 Months 36 Months – Pre-schoolOver Preschool age
  filter :url, :label => AdminConstants::ADMIN_PROVIDER_URL_FILTER
  filter :waitlist_fee

  index do

    selectable_column

    column "Name (click for details)", :sortable => 'name' do |provider|
      render provider
      render provider.rolodexes
      render provider.addresses
      render provider.services
    end

    column :address

    column :company, :sortable => 'name'

    column :description
    
    column "Care Options", :sortable => 'care_offered' do |provider|
      provider.care_offered
      end 

    column "Places" do |provider|
      provider.approved_places
    end

    column "Ages", :sortable => 'age_range' do |provider| 
      provider.age_range 
    end

    column "Fee", :sortable => 'fee'  do |provider| 
      number_to_currency(provider.fee) 
    end
    
    column :waitlist_fee, :sortable => 'waitlist_fee'

    column :waitlist_reimbursed

    column :hours
    
    column :languages

  end # indexø

  form do |f|
    f.semantic_errors *f.object.errors.keys
    #error_panel f

    f.inputs "Provider Details" do

      f.input :name, 
              :hint         => AdminConstants::ADMIN_PROVIDER_NAME_HINT,
              :placeholder  => AdminConstants::ADMIN_PROVIDER_NAME_PLACEHOLDER

      f.input :approval_number

      f.input :company,
              :hint         => AdminConstants::ADMIN_PROVIDER_COMPANY_HINT
      
      f.input :description

      f.input :NQS_rating,
              :hint         => AdminConstants::ADMIN_PROVIDER_NQS_RATING_HINT,
              :placeholder  => AdminConstants::ADMIN_PROVIDER_NQS_RATING_PLACEHOLDER
      
      f.input :care_offered,
              :collection    => AdminConstants::ADMIN_PROVIDER_CARE_OFFERED_COLLECTION,
              :hint          => AdminConstants::ADMIN_PROVIDER_CARE_HINT

      f.input :age_range,
              :hint          => AdminConstants::ADMIN_PROVIDER_AGE_HINT,
              :placeholder   => AdminConstants::ADMIN_PROVIDER_AGE_PLACEHOLDER

      f.input ('fee') { number_to_currency(provider.fee)}

      f.input :hours

      f.input :additional_activities
      f.input :additional_activities_list
      f.input :air_conditioning
      f.input :bus_service
      f.input :cloth_nappies
      f.input :disability_friendly
      f.input :disabilities_list,
              :label         => AdminConstants::ADMIN_PROVIDER_DISABILITY_FRIENDLY_LABEL,
              :hint          => AdminConstants::ADMIN_PROVIDER_DISABILITY_FRIENDLY_HINT
      f.input :disposable_nappies
      f.input :excursions
      f.input :extended_hours_for_kindys
      f.input :food_provided
      f.input :guest_speakers
      f.input :kindergarten,
              :label         => AdminConstants::ADMIN_PROVIDER_KINDERGARTEN_LABEL,
              :hint          => AdminConstants::ADMIN_PROVIDER_KINDERGARTEN_HINT
      f.input :languages,
              :collection    => AdminConstants::ADMIN_PROVIDER_LANGUAGE_LIST_COLLECTION,
              :label         => AdminConstants::ADMIN_PROVIDER_LANGUAGE_LABEL,
              :hint          => AdminConstants::ADMIN_PROVIDER_LANGUAGE_HINT
      f.input :languages_list,
              :hint          => AdminConstants::ADMIN_PROVIDER_LANGUAGE_LIST_HINT
      f.input :online_enrollment
      f.input :outdoor_play_area
      
      f.input :provider_legal_name
      
      f.input :quality_area_rating_1
      f.input :quality_area_rating_2
      f.input :quality_area_rating_3
      f.input :quality_area_rating_4
      f.input :quality_area_rating_5
      f.input :quality_area_rating_6
      f.input :quality_area_rating_7

      f.input :real_grass

      f.input :secure_access
      f.input :service_approval_number
      f.input :sibling_priority

      f.input :technology
      f.input :technologies_list

      f.input :url

      f.input :vacancies
      f.input :vacancies_list,
              :hint          => AdminConstants::ADMIN_PROVIDER_VACANCIES_LIST_HINT

      f.input :vaccinations_compulsory

      f.input :waitlist_online
      f.input :waitlist_reimbursed
      f.input ('waitlist_fee') { number_to_currency(provider.waitlist_fee) }

      f.input :address,
              :hint          => AdminConstants::ADMIN_PROVIDER_ADDRESS_HINT,
              :placeholder   => AdminConstants::ADMIN_PROVIDER_ADDRESS_PLACEHOLDER
              
    end


    f.inputs do
      f.has_many :addresses, :allow_destroy => true, :as => :boolean, :heading => 'Address or Location', :new_record => true do |addr|
          addr.input :street
          addr.input :locality
          addr.input :state
          addr.input :post_code
        end
      end

    f.inputs "Rolodexes" do
      f.has_many :rolodexes, :allow_destroy => true, :as => :boolean, :new_record => true do |r|
        r.input :number_or_email
        r.input :kind
        r.input :when_to_use
      end
    end

    f.inputs "Services" do
      f.has_many :services, :allow_destroy => true, :as => :boolean, :new_record => true do |s|
        s.input :name
        s.input :description
        s.input :fee
        s.input :basis
      end
    end

    f.inputs "Certs (Certificates)" do
      f.has_many :certs, :allow_destroy => true, :as => :boolean, :new_record => true do |f|

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
#      row ( "Address") { render provider.addresses}
      row :address
      row ( "Additional Activities" ) { status_tag (provider.additional_activities ? "YES" : "No"), (provider.additional_activities ? :ok : :error) }
      row :additional_activities_list
      row ( "Age Range") { provider.age_range }
      row ( "Air Conditioning" ) { status_tag (provider.air_conditioning ? "YES" : "No"), (provider.air_conditioning ? :ok : :error) }
      row :approval_granted_on
      row :approval_number
      row :approved_places

      row ( "Bus Service" ) { status_tag (provider.bus_service ? "YES" : "No"), (provider.bus_service ? :ok : :error) }

      row :care_offered
      row ( "Certifications" ) { render provider.certs}
      row ( "Cloth Nappies" ) { status_tag (provider.cloth_nappies ? "YES" : "No"), (provider.cloth_nappies ? :ok : :error) }
      row :company
      row :conditions_on_approval
      row :created_at

      row :description
      row ( "Disability Friendly") { status_tag (provider.disability_friendly ? "YES" : "No"), (provider.disability_friendly ? :ok : :error) }
      row :disabilities_list
      row ( "Disposable Nappies" ) { status_tag (provider.disposable_nappies ? "YES" : "No"), (provider.disposable_nappies ? :ok : :error) }

      row ( "Excursions" ) { status_tag (provider.excursions ? "YES" : "No"), (provider.excursions ? :ok : :error) }
      row ( "Extended Hours for Kindys" ) { status_tag (provider.extended_hours_for_kindys ? "YES" : "No"), 
        (provider.extended_hours_for_kindys ? :ok : :error) }

      row ( 'fee' ) {number_to_currency(provider.fee)}
      row ( "Food Provided" ) { status_tag (provider.food_provided ? "YES" : "No"), (provider.food_provided ? :ok : :error) }
      
      row ( "Guest Speakers" ) { status_tag (provider.guest_speakers ? "YES" : "No"), (provider.guest_speakers ? :ok : :error) }

      row :hours

      row (:kindergarten) { status_tag (provider.kindergarten ? "Yes" : "no"), (provider.kindergarten ? :ok : :error) }

      row :languages
      row :languages_list
      row :legal_name

      row :NQS_rating

      row ( "On-line Enrollment" ) { status_tag (provider.online_enrollment ? "YES" : "No"), (provider.online_enrollment ? :ok : :error) }
      row ( "Outdoor Play Area" ) { status_tag (provider.outdoor_play_area ? "YES" : "No"), (provider.outdoor_play_area ? :ok : :error) }

      row :provider_legal_name

      row :quality_area_rating_1
      row :quality_area_rating_2
      row :quality_area_rating_3
      row :quality_area_rating_4
      row :quality_area_rating_5
      row :quality_area_rating_6
      row :quality_area_rating_7
      row :quality_overall_rating

      row ( "Real Grass" ) { status_tag (provider.real_grass ? "YES" : "No"), (provider.real_grass ? :ok : :error) }
      row ( "Rolodex" ) {render provider.rolodexes}

      row ( "Secure Access" ) { status_tag (provider.secure_access ? "YES" : "No"), (provider.secure_access ? :ok : :error) }
      row :service_approval_number
      row ( "Services") { render provider.services}
      row ( "Sibling Given Priority" ) { status_tag (provider.sibling_priority ? "YES" : "No"), (provider.sibling_priority ? :ok : :error) }

      row ( "Technology" ) { status_tag (provider.technology ? "YES" : "No"), (provider.technology ? :ok : :error) }
      row :technologies_list

      row :updated_at
      row ( "Vacancies" ) { status_tag (provider.vacancies ? "YES" : "No"), (provider.vacancies ? :ok : :error) }
      row :vacancies_list
      row ( "Vaccinations Compulsory" ) { status_tag (provider.vaccinations_compulsory ? "YES" : "No"), (provider.vaccinations_compulsory ? :ok : :error) }

      row ( "Wait List Fee" ) {number_to_currency(provider.waitlist_fee)}
      row ( "Waitlist Online" ) { status_tag (provider.waitlist_online ? "YES" : "No"), (provider.waitlist_online ? :ok : :error) }
      row ( "Waitlist Fee Reimbursed" ) { status_tag (provider.waitlist_reimbursed ? "YES" : "No"), (provider.waitlist_reimbursed ? :ok : :error) }

      row ( "Web Site" ) { link_to "#{provider.url}", href="http://#{provider.url}", target: '_blank' }

      end
    active_admin_comments
  end #show


#
# batch actions
#
  # add selected providers to user's list of prefered care providers
  # This works:  current_admin_user.email
  # http://stackoverflow.com/questions/4149326/rails-devise-get-object-of-the-currently-logged-in-user
  batch_action :add_to_favorites, confirm: "Add selected providers to your favorite providers list??" do |selection|
    @guardian = Guardian.where(handle: current_admin_user.email)
    @guardian = @guardian[0]
    Provider.find(selection).each do |provider|
      @guardian.providers << provider
    end
    
    #redirect_to admin_providers_path
    redirect_to admin_guardians_path
  end

  # remove_provider -- remove provider from user's list of prefered providers
  # Do not destroy guardian or provider objects.
  # http://apidock.com/rails/ActiveRecord/Associations/ClassMethods/has_and_belongs_to_many
  batch_action :clear_favorites_list, confirm: "Clear all providers from your list of selected providers?" do |selection|
    @guardian = Guardian.where(handle: current_admin_user.email)
    @guardian = @guardian[0]
    unless @guardian.nil?
      gps = @guardian.providers
      gps.clear
    end
    #redirect_to admin_providers_path
    redirect_to admin_providers_path, {:notice => "My list of providers."}
  end

#
# P E R M I T  P A R A M S
#
# NOTE:  polymorphs cannot be deleted if :id attribute is not given here; no error message occurs,
# however records will duplicate on every update.
#
  
  permit_params(  :id,
    :additional_activities, 
    :additional_activities_list, 
    :address,
    :age_range, 
    :air_conditioning, 
    :approval_number,
    :approved_places, 

    :bus_service, 

    :care_offered, 
    :cloth_nappies, 
    :company_id,

    :description, 
    :disposable_nappies,
    :disability_friendly,
    :disabilities_list,

    :extended_hours_for_kindys, 
    :excursions, 
    
    :fee, 
    :food_provided,

    :guest_speakers, 
    :hours, 
    :id, 

    :kindergarten,

    :languages, :languages_list,
    
    :name, 
    :NQS_rating, :url,

    :online_enrollment, 
    :outdoor_play_area, :overall_rating,

    :real_grass,

    :secure_access, :service_approval_number, :sibling_priority, 
    
    :provider_approval_number, :provider_legal_name,

    :quality_area_rating_1, :quality_area_rating_2, :quality_area_rating_3, :quality_area_rating_4,
    :quality_area_rating_5, :quality_area_rating_6, :quality_area_rating_7, 
    
    :technology, :technologies_list,

    :url,
    :vacancies, :vacancies_list,
    :vaccinations_compulsory,

    :waitlist_fee, 
    :waitlist_online, 
    :waitlist_reimbursed,

      addresses_attributes: [ :id, :street, :locality, :state, :post_code, :country, :latitude, :longitude, :_destroy],
      rolodexes_attributes: [ :id, :number_or_email, :kind, :when_to_use, :description, :_destroy],
      certs_attributes:     [ :id, :certificate_id, :serial_number, :expires_on, :active, :_destroy ],
      services_attributes:  [ :id, :name, :description, :fee, :basis, :_destroy ]
    )

end
