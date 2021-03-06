ActiveAdmin.register WaitlistApplication do

#
# C A L L  B A C K S
#
# If there are no providers or if there are no guardians do not allow new waitlist_applications.
#
  before_build do |wla|
    flash[:error] = AdminConstants::ADMIN_WAITLIST_APPLICATION_MISSING_PROVIDERS unless Provider.any?
    flash[:error] = AdminConstants::ADMIN_WAITLIST_APPLICATION_MISSING_GUARDIANS unless Guardian.any?
  end

  
  index do

    selectable_column

    column :guardian
    
    column "Name (click for details)", :sortable => 'guardian' do |wla|
      render wla
      render wla.rolodexes
      render wla.addresses
    end
 
  end # indexø

  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs "Waitlist Application Details" do |wla|

      f.input :guardian,
              :include_blank => false,
              :hint          => AdminConstants::ADMIN_WAITLIST_APPLICATION_GUARDIAN_HINT

      f.input :lodged_by,
              :as            => :select, 
              :collection    => Guardian.alphabetically.all.map, #{|guardian| [guardian., guardian.id]}, 
              :include_blank => false

      f.input :lodged_on,
              :as   => :date_picker,
              :hint => AdminConstants::ADMIN_WAITLIST_APPLICATION_LODGED_BY_HINT


      f.input :active, 
              :as => :radio
    end

    f.inputs "Child Details" do |wla|

      f.input :lodged_for,
              :hint => AdminConstants::ADMIN_WAITLIST_APPLICATION_LODGED_FOR_HINT

      f.input :enrollment_goal,
              :hint => AdminConstants::ADMIN_WAITLIST_APPLICATION_ENROLMENT_GOAL_HINT

      f.input :enrollment_goal_date,
              :as => :date_picker,
              :hint => AdminConstants::ADMIN_WAITLIST_APPLICATION_ENROLMENT_DATE_HINT

      f.input :enrolled_on,
              :as => :date_picker,
              :hint => AdminConstants::ADMIN_WAITLIST_APPLICATION_ENROLED_ON_HINT

      f.input :gender,
              :as => :radio,
              :collection => [["Male", 1], ["Female", 2]]

      f.input :dob,
              :as    => :date_picker,
              :label => AdminConstants::ADMIN_WAITLIST_APPLICATION_DOB_LABEL,
              :hint  => AdminConstants::ADMIN_WAITLIST_APPLICATION_DOB_HINT

      #f.input :born_country #f.country_select :country_code

      f.input :confined_on,
              :as => :date_picker

      f.input :languages_spoken_at_home,
              :hint => AdminConstants::ADMIN_WAITLIST_APPLICATION_LANGUAGES_HINT,
              :placeholder => AdminConstants::ADMIN_WAITLIST_APPLICATION_LANGUAGES_PLACEHOLDER

      f.input :special_needs,
              :hint  => AdminConstants::ADMIN_WAITLIST_APPLICATION_SPECIAL_NEEDS_HINT,
              :placeholder => AdminConstants::ADMIN_WAITLIST_APPLICATION_SPECIAL_NEEDS_PLACEHOLDER

      f.input :cultural_needs,
              :hint  => AdminConstants::ADMIN_WAITLIST_APPLICATION_CULTURAL_NEEDS_HINT,
              :placeholder => AdminConstants::ADMIN_WAITLIST_APPLICATION_CULTURAL_NEEDS_PLACEHOLDER

    end

    f.inputs "Mother's Details" do |wla|
      f.input :mothers_name
      f.input :mothers_occupation
      f.input :mothers_hours_of_work
      f.input :mothers_employer
      f.input :mothers_employment_status
      f.input :mother_is_aboriginal_descent
      f.input :mother_has_other_children
      f.input :mother_dependents_count
    end

    f.inputs "Father's Details" do |wla|
      f.input :fathers_name
      f.input :fathers_occupation
      f.input :fathers_hours_of_work
      f.input :fathers_employer
      f.input :fathers_employment_status
      f.input :father_is_aboriginal_descent
      f.input :father_has_other_children
      f.input :father_dependents_count
    end

    f.inputs "Schedule Details" do |wla|
      f.input :number_care_days_required
      f.input :care_day_sunday
      f.input :care_day_monday
      f.input :care_day_tuesday
      f.input :care_day_wednesday
      f.input :care_day_thursday
      f.input :care_day_friday
      f.input :care_day_saturday
      f.input :will_accept_available
    end

    f.inputs "Special Circumstances" do |wla|
      f.input :special_circumstances
    end
    f.actions
  end # form

#
# P A R A M E T E R  L I S T
#

  permit_params  :guardian_id,
    :lodged_on,
    :lodged_by,
    :lodged_for,
    :active,
    :form_name,


    :enrollment_goal,
    :enrollment_goal_date,
    :enroled_on,
    :gender,
    :dob,
    :born_country,
    :confined_on,
    :languages_spoken_at_home,
    :special_needs,
    :cultural_needs,

    :mothers_name,
    :mothers_occupation,
    :mothers_hours_of_work,
    :mothers_employer,
    :mothers_employment_status,
    :mother_is_aboriginal_descent,
    :mother_has_other_children,
    :mother_dependents_count,

    :fathers_name,
    :fathers_occupation,
    :fathers_hours_of_work,
    :fathers_employer,
    :fathers_employment_status,
    :father_is_aboriginal_descent,
    :father_has_other_children,
    :father_dependents_count,

    :number_care_days_required,
    :care_day_sunday,
    :care_day_monday,
    :care_day_tuesday,
    :care_day_wednesday,
    :care_day_thursday,
    :care_day_friday,
    :care_day_saturday,
    :will_accept_available,
    
    :special_circumstances,

    :updated_at,
      addresses_attributes: [:id, :street, :locality, :state, :post_code, :country, :latitude, :longitude, :_destroy],
      rolodexes_attributes: [:id, :number_or_email, :kind, :when_to_use, :description, :_destroy],
      certs_attributes: [ :id, :certificate_id, :serial_number, :expires_on, :active, :_destroy ]

  
end
