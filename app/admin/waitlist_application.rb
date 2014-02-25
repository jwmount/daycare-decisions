ActiveAdmin.register WaitlistApplication do

  
  index do

    selectable_column

    column "Name (click for details)", :sortable => 'name' do |provider|
      render waitlist_application
      render waitlist_application.rolodexes
      render waitlist_application.addresses
    end
 
  end # indexø

  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs "Waitlist Application Details" do |wla|

      f.input :guardian,
              :include_blank => false

      f.input :provider,
              :include_blank => false

      f.input :lodged_by
      f.input :lodged_on
    end

    f.inputs "Mother's Details" do |wla|
      f.input :mothers_name
    end

    f.inputs "Father's Details" do |wla|
      f.input :fathers_name
    end

  end # form


  show :title => :name do
    attributes_table do
      row :guardian_id
      row :provider_id
      row :special_needs
      row :description
      row("Mother is aboriginal descent") { status_tag (waitlist_application.mother_is_aboriginal_descent ? "YES" : "No"), (waitlist_application.mother_is_aboriginal_descent ? :ok : :error) }
    end
  end

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
