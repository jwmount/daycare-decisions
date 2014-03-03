ActiveAdmin.register WaitlistApplication do

  
  index do

    selectable_column

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
              :include_blank => false #,
              #:placeholder => AdminConstants::ADMIN_WLA_GUARDIAN_PLACEHOLDER

      f.input :lodged_by

      f.input :lodged_on

      f.input :active, 
              :as => :radio
    end

    f.inputs "Child Details" do |wla|
      f.input :lodged_for
      f.input :enrolment_goal
      f.input :enrolment_goal_date
      f.input :enroled_on
      f.input :gender
      f.input :dob
      #f.input :born_country #f.country_select :country_code
      f.input :confined_on
      f.input :languages_spoken_at_home
      f.input :special_needs
      f.input :cultural_needs
    end
    f.actions

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
    f.actions

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
    f.actions

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
    f.actions

    f.inputs "Special Circumstances" do |wla|
      f.input :special_circumstances
    end
    f.actions
  end # form

#
# P A R A M E T E R  L I S T
#

  permit_params  :guardian_id,
    :provider_id,
    :lodged_on,
    :lodged_by,
    :lodged_for,
    :active,
    :form_name,


    :enrolment_goal,
    :enrolment_goal_date,
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
      addresses_attributes: [:id, :street, :suburb, :state, :post_code, :lat, :long, :_destroy],
      rolodexes_attributes: [:id, :number_or_email, :kind, :when_to_use, :description, :_destroy],
      certs_attributes: [ :id, :certificate_id, :serial_number, :expires_on, :active, :_destroy ]

  
end
