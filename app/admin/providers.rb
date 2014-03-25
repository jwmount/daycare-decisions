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
  scope :waitlist_online do |providers|
    providers.where ({waitlist_online: true})
  end
  scope :online_enrollment do |providers|
    providers.where ({online_enrollment: true})
  end
  scope :security_access do |providers|
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
  scope :sibling_priority do |providers|
    providers.where ({sibling_priority: true})
  end
  scope :waitlist_reimbursed do |providers|
    providers.where ({waitlist_reimbursed: true})
    # works fine: providers.where ({waitlist_reimbursed: true, cloth_nappies: true})
    # question is, how to show this?
  end
  scope :vacancies do |providers|
    providers.where ({vacancies: true})
  end


  filter :company
  filter :name
  filter :care_offered, :label => "Care Options"
  filter :NQS_rating
  filter :fee
  filter :description
  filter :url
  filter :languages, :label => "Language Skills Training"
  filter :vacancies          # Vacancies 0-12mths 13-24mths 25-35 Months 36 Months – Pre-schoolOver Preschool age
  filter :waitlist_fee

  index do

    selectable_column

    column "Name (click for details)", :sortable => 'name' do |provider|
      render provider
      render provider.rolodexes
      render provider.addresses
      render provider.services
    end

    column :company, :sortable => 'name'

    column :description
    
    column "Care Options", :sortable => 'care_offered' do |provider|
      provider.care_offered
      end 
    column :NQS_rating, :sortable => 'nqs_rating'

    column "Ages", :sortable => 'age' do |provider| 
      provider.age 
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

      f.input :company,
              :hint         => AdminConstants::ADMIN_PROVIDER_COMPANY_HINT
      
      f.input :description

      f.input :NQS_rating,
              :hint         => AdminConstants::ADMIN_PROVIDER_NQS_RATING_HINT,
              :placeholder  => AdminConstants::ADMIN_PROVIDER_NQS_RATING_PLACEHOLDER
      
      f.input :care_offered,
              :collection    => care_options,
              :hint          => AdminConstants::ADMIN_PROVIDER_CARE_HINT,
              :placeholder   => AdminConstants::ADMIN_PROVIDER_CARE_PLACEHOLDER

      f.input :age,
              :hint          => AdminConstants::ADMIN_PROVIDER_AGE_HINT,
              :placeholder   => AdminConstants::ADMIN_PROVIDER_AGE_PLACEHOLDER

      f.input ('fee') { number_to_currency(provider.fee)}

      f.input :hours

      f.input :languages,
              :label         => AdminConstants::ADMIN_PROVIDER_LANGUAGE_LABEL,
              :hint          => AdminConstants::ADMIN_PROVIDER_LANGUAGE_HINT,
              :placeholder   => AdminConstants::ADMIN_PROVIDER_LANGUAGE_PLACEHOLDER
              
      f.input :vacancies
      f.input ('waitlist_fee')  { number_to_currency(provider.waitlist.fee) }
      f.input :waitlist_reimbursed
    end

    f.inputs do
      f.has_many :addresses, :allow_destroy => true, :as => :boolean, :heading => 'Address or Location', :new_record => true do |addr|
          addr.input :street_address
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
      row :name
      row ("Address") { render provider.addresses}
      row ("Age Range") { provider.age }
      row :care_offered
      row ("Certifications") { render provider.certs}
      row ("Services") { render provider.services}
      row :company
      row :description

      row ( 'fee' ) {number_to_currency(provider.fee)}
      row :hours
      row :languages
      row :NQS_rating
      row :waitlist_fee
      row ( "Rolodex" ) {render provider.rolodexes}
      row ( "Web Site" ) { link_to "#{provider.url}", href="http://#{provider.url}", target: '_blank' }

      row ( "Additional Activities Included") { status_tag (provider.additional_activities_included ? "YES" : "No"), (provider.additional_activities_included ? :ok : :error) }
      row ( "Air Conditioning" ) { status_tag (provider.air_conditioning ? "YES" : "No"), (provider.air_conditioning ? :ok : :error) }
      row ( "Bus Service" ) { status_tag (provider.bus_service ? "YES" : "No"), (provider.bus_service ? :ok : :error) }
      row ( "Cloth Nappies" ) { status_tag (provider.cloth_nappies ? "YES" : "No"), (provider.cloth_nappies ? :ok : :error) }
      row ( "Disposable Nappies" ) { status_tag (provider.disposable_nappies ? "YES" : "No"), (provider.disposable_nappies ? :ok : :error) }
      row ( "Excursions" ) { status_tag (provider.excursions ? "YES" : "No"), (provider.excursions ? :ok : :error) }
      row ( "Extended Hours for Kindys" ) { status_tag (provider.extended_hours_for_kindys ? "YES" : "No"), 
        (provider.extended_hours_for_kindys ? :ok : :error) }
      row ( "Food Provided" ) { status_tag (provider.food_provided ? "YES" : "No"), (provider.food_provided ? :ok : :error) }
      row ( "Guest Speakers" ) { status_tag (provider.guest_speakers ? "YES" : "No"), (provider.guest_speakers ? :ok : :error) }
      row ( "On-line Enrollment" ) { status_tag (provider.online_enrollment ? "YES" : "No"), (provider.online_enrollment ? :ok : :error) }
      row ( "On-line Waitlist" ) { status_tag (provider.waitlist_online ? "YES" : "No"), (provider.waitlist_online ? :ok : :error) }
      row ( "Outdoor Play Area" ) { status_tag (provider.outdoor_play_area ? "YES" : "No"), (provider.outdoor_play_area ? :ok : :error) }

      row ( "Real Grass" ) { status_tag (provider.real_grass ? "YES" : "No"), (provider.real_grass ? :ok : :error) }
      row ( "Security Access" ) { status_tag (provider.security_access ? "YES" : "No"), (provider.security_access ? :ok : :error) }
      row ( "Sibling Has Priority" ) { status_tag (provider.sibling_priority ? "YES" : "No"), (provider.sibling_priority ? :ok : :error) }
      row ( "Technology" ) { status_tag (provider.technology ? "YES" : "No"), (provider.technology ? :ok : :error) }
      row ( "Vacancies" ) { status_tag (provider.vacancies ? "YES" : "No"), (provider.vacancies ? :ok : :error) }
      row ( "Waitlist Fee Refund" ) { status_tag (provider.waitlist_reimbursed ? "YES" : "No"), (provider.waitlist_reimbursed ? :ok : :error) }

      row :service_approval_number
      row :approval_number
      row :legal_name
      row :conditions_on_approval
      row :approved_places
      row :approval_granted_on
      row :quality_area_rating_1
      row :quality_area_rating_2
      row :quality_area_rating_3
      row :quality_area_rating_4
      row :quality_area_rating_5
      row :quality_area_rating_6
      row :quality_area_rating_7
      row :overall_rating
      row :food
      row :online_enrolment
      row :security

      end
    active_admin_comments
  end #show


#
# batch actions
#
  # add selected providers to user's list of prefered care providers
  # This works:  current_admin_user.email
  # http://stackoverflow.com/questions/4149326/rails-devise-get-object-of-the-currently-logged-in-user
  batch_action :add_to_list, confirm: "Add selected providers to your prefered provider list??" do |selection|
    @guardian = Guardian.first
    @guardian.handle = current_admin_user.email
    @guardian.save!

    @guardian = Guardian.where(handle: current_admin_user.email)
    @guardian = @guardian[0]
    @guardian.providers.clear

    Provider.find(selection).each do |provider|
      @guardian.providers << provider
    end
    
    redirect_to admin_providers_path
  end

  # remove_provider -- remove provider from user's list of prefered providers
  # Do not destroy guardian or provider objects.
  # http://apidock.com/rails/ActiveRecord/Associations/ClassMethods/has_and_belongs_to_many
  batch_action :clear_list, confirm: "Clear all providers from your list of selected providers?" do |selection|
    @guardian = Guardian.first
    gps = @guardian_providers unless @guardian.nil?
    gps.clear unless gps.nil?
    #redirect_to admin_providers_path
    redirect_to admin_providers_path, {:notice => "My list of providers."}
  end
 

#
# P E R M I T  P A R A M S
#
# NOTE:  polymorphs cannot be deleted if :id attribute is not given here; no error message occurs,
# however records will duplicate on every update.
#
  permit_params :additional_activities_included, :age, :company_id, :name, :care, :description, :disposable_nappies, :cloth_nappies,
    :hours, :NQS_rating, :languages, :url, :id, :food_provided, :air_conditioning,
    :bus_service, :extended_hours_for_kindys, :fee, 
    :online_enrollment, :security_access,
    :excursions, :guest_speakers, :outdoor_play_area, :real_grass,
    :technology, :sibling_priority, :vacancies,
    :approved_places, :provider_approval_number, :service_approval_number, :provier_legal_name,
    :quality_area_rating_1, :quality_area_rating_2, :quality_area_rating_3, :quality_area_rating_4,
    :quality_area_rating_5, :quality_area_rating_6, :quality_area_rating_7, :overall_rating,
    :waitlist_fee, :waitlist_online, :waitlist_reimbursed,
      addresses_attributes: [ :id, :street_address, :locality, :state, :post_code, :lat, :long, :_destroy],
      rolodexes_attributes: [ :id, :number_or_email, :kind, :when_to_use, :description, :_destroy],
      certs_attributes:     [ :id, :certificate_id, :serial_number, :expires_on, :active, :_destroy ],
      services_attributes:  [ :id, :name, :description, :fee, :basis, :_destroy ]

end
