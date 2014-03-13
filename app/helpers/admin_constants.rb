# If these values are changed, re-run migrations or reload schema
# $ bundle exec rake db:drop db:create db:schema:load db:seed
# Internationalization, see http://stackoverflow.com/questions/3629894/internationalization-for-constants-hashes-in-rails-3

module AdminConstants
  
#
# Addresses
#
  ADMIN_ADDRESS_OWNER_NOT_FOUND          = "Company does not exist, address should be deleted."
  ADMIN_ADDRESS_PERSON_NOT_FOUND         = "Person does not exist, address should be deleted."
  ADMIN_ADDRESS_PROJECT_NOT_FOUND        = "Project does not exist, address should be deleted."
  ADMIN_ADDRESS_TIP_NOT_FOUND            = "Tip does not exist, address should be deleted."
#
# Company
#
  ADMIN_COMPANY_ACTIVE                   = "Company is active."
  ADMIN_COMPANY_INACTIVE                 = "Company is not active.  Projects cannot be defined."

  ADMIN_COMPANY_NAME_HINT                = "Company name.  Must be unique."
  ADMIN_COMPANY_NAME_PLACEHOLDER         = "Company name"

  ADMIN_COMPANY_LINE_OF_BUSINESS_HINT    = "What the company does."

  ADMIN_COMPANY_URL_LABEL                = "Web Site"
  ADMIN_COMPANY_URL_PLACEHOLDER          = "www.company_name.com"
  ADMIN_COMPANY_URL_HINT                 = "Web site, URL."

  ADMIN_COMPANY_BOOKEEPING_NO_BASE       = '10000'
  ADMIN_COMPANY_BOOKEEPING_NO_MAX        = '99999'
  ADMIN_COMPANY_BOOKEEPING_NO_DEFAULT    = '00000'
  ADMIN_COMPANY_BOOKEEPING_NO_HINT       = "Bookeeping account number for this company; unique, five digits."

  ADMIN_COMPANY_CREDIT_TERMS_DEFAULT     = 30
  ADMIN_C0MPANY_CREDIT_TERMS_LABEL       = "Credit Terms (Days)", 
  ADMIN_C0MPANY_CREDIT_TERMS_HINT        = "Number of days we will extend credit, if any."
  ADMIN_C0MPANY_CREDIT_TERMS_PLACEHOLDER = "Days"
              
  ADMIN_C0MPANY_PO_REQUIRED_LABEL        = "Purchase Order Required"

#
# Certs
#
  ADMIN_CERT_EXPIRES_ON_HINT             = "Expriation date."
  ADMIN_CERT_SERIAL_NUMBER_HINT          = "Value that makes the certificate unique.  For example, License Number, Rego, etc."

#
# Guardians
#
  ADMIN_GUARDIAN_FIRST_NAME_HINT         = "Name or something."
  ADMIN_GUARDIAN_FIRST_NAME_PLACEHOLDER  = "first name"
  
  ADMIN_GUARDIAN_SURNAME_HINT            = "Surname"
  ADMIN_GUARDIAN_SURNAME_PLACEHOLDER     = "Surname"
  
#
# Person
#
  ADMIN_PERSON_FIRST_NAME_LABEL          = ""
  ADMIN_PERSON_FIRST_NAME_HINT           = "First name should be entered if possible."
  ADMIN_PERSON_FIRST_NAME_PLACEHOLDER    = "First name"

  ADMIN_PERSON_LAST_NAME_LABEL           = ""
  ADMIN_PERSON_LAST_NAME_HINT            = "Required."
  ADMIN_PERSON_LAST_NAME_PLACEHOLDER     = "Last name"

  ADMIN_PERSON_TITLE_LABEL               = ""
  ADMIN_PERSON_TITLE_HINT                = ""
  ADMIN_PERSON_TITLE_PLACEHOLDER         = "Title"

#
# Provider
#

  ADMIN_PROVIDER_AGE_LABEL               = ""
  ADMIN_PROVIDER_AGE_HINT                = "Age range accomodated.  For example, '3 to 6 months'."
  ADMIN_PROVIDER_AGE_PLACEHOLDER         = "3 to 6 months"

  ADMIN_PROVIDER_NAME_LABEL              = "Provider Name"
  ADMIN_PROVIDER_NAME_HINT               = "Provider name"
  ADMIN_PROVIDER_NAME_PLACEHOLDER        = "ABC Child Care"

  ADMIN_PROVIDER_CARE_HINT               = "Type of care provided."
  ADMIN_PROVIDER_CARE_PLACEHOLDER        = "Long Day"

  ADMIN_PROVIDER_COMPANY_HINT            = "Company that owns or operates this facility."

  ADMIN_PROVIDER_NQS_RATING_LABEL        = "NQS rating"
  ADMIN_PROVIDER_NQS_RATING_PLACEHOLDER  = "1...3"
  ADMIN_PROVIDER_NQS_RATING_HINT         = "describe what an NQS rating means"

  ADMIN_PROVIDER_LANGUAGE_LABEL          = "Languages Available"
  ADMIN_PROVIDER_LANGUAGE_PLACEHOLDER    = "English"
  ADMIN_PROVIDER_LANGUAGE_HINT           = "Language options offered"

# 
# Requirements
#
# none
#
# Rolodexes
#
  ADMIN_ROLODEX_NUMBER_OR_EMAIL_COLLECTION       = %w[Mobile Email Office Truck Pager FAX Skype SMS Twitter Home URL]
  ADMIN_ROLODEX_NUMBER_OR_EMAIL_LABEL            = "Type or kind of device or mode."
  ADMIN_ROLODEX_NUMBER_OR_EMAIL_HINT             = "Kind of device or way to communicate with this Person.  Cannot be blank. E.g. person@company.com."
  ADMIN_ROLODEX_NUMBER_OR_EMAIL_PLACEHOLDER      = "0408 399 099"

  ADMIN_ROLODEX_KIND_LABEL                       = "Phone Number, address, etc."            
  ADMIN_ROLODEX_KIND_HINT                        = "Number, address, etc.  For example, 514 509-8381, or info@somecompany.com."
  ADMIN_ROLODEX_KIND_PLACEHOLDER                 = "Phone number, email address, ..."

  ADMIN_ROLODEX_WHEN_TO_USE_LABEL                = "Priority of use."
  ADMIN_ROLODEX_WHEN_TO_USE_HINT                 = "Order prefered."
  ADMIN_ROLODEX_WHEN_TO_USE_PLACEHOLDER          = "1..9"

#
# Roles
#
# no roles

#
# Services


  ADMIN_SERVICE_NAME_HINT                          = "Name of the service, e.g. Ages 6 - 12 months tuition ($/hr)"
  ADMIN_SERVICE_NAME_PLACEHOLDER                   = "Ages 6 - 12 months tuition ($/hr)"

  ADMIN_SERVICE_DESCRIPTION_HINT                   = "Description of the service offered, e.g. Tuition ($/hr)"
  ADMIN_SERVICE_DESCRIPTION_PLACEHOLDER            = "Tuition ($/hr)"

  ADMIN_SERVICE_FEE_HINT                           = "Service Price"
  ADMIN_SERVICE_FEE_PLACEHOLDER                    = "70.00"

  ADMIN_SERVICE_BASIS_HINT                         = "Price basis, e.g. $/hr, $/day, $/month, included in overall rate,..."
  ADMIN_SERVICE_BASIS_PLACEHOLDER                  = "$/hr"

#
# WAITLIST_APPLICATION
#
  ADMIN_WAITLIST_APPLICATION_MISSING_PROVIDERS     = "No providers exists, you must create at least one before you proceed."
  ADMIN_WAITLIST_APPLICATION_MISSING_GUARDIANS     = "No guardians exist, you must create at least one before you proceed."

  ADMIN_WAITLIST_APPLICATION_GUARDIAN_LABEL        = "Guardian (Parent)"
  ADMIN_WAITLIST_APPLICATION_GUARDIAN_HINT         = "Person responsible for this application."
  ADMIN_WAITLIST_APPLICATION_GUARDIAN_PLACEHOLDER  = "Shorter one"

  ADMIN_WAITLIST_APPLICATION_LODGED_BY_NAME        = "Person lodging this application"
  ADMIN_WAITLIST_APPLICATION_LODGED_BY_HINT        = "Person lodging this application"
  ADMIN_WAITLIST_APPLICATION_LODGED_BY_PLACEHOLDER = "Name"
  
  ADMIN_WAITLIST_APPLICATION_LODGED_ON_NAME        = ""  
  ADMIN_WAITLIST_APPLICATION_LODGED_ON_HINT        = "Date application was or will be lodged with Daycare Decisions"
  ADMIN_WAITLIST_APPLICATION_LODGED_ON_PLACEHOLDER  = ""

  ADMIN_WAITLIST_APPLICATION_ACTIVE_HINT           = "State of this application."

  ADMIN_WAITLIST_APPLICATION_LODGED_FOR_HINT       = "Name of child or person to be enroled."
  ADMIN_WAITLIST_APPLICATION_ENROLMENT_GOAL_HINT   = "? To be defined."

  ADMIN_WAITLIST_APPLICATION_ENROLMENT_DATE_HINT   = "Date care services should be available."
  ADMIN_WAITLIST_APPLICATION_ENROLED_ON_HINT       = "Actual enrol date."

  ADMIN_WAITLIST_APPLICATION_DOB_LABEL             = "Enrolee's date of birth"
  ADMIN_WAITLIST_APPLICATION_DOB_HINT              = "Enrolee's birth date."

  ADMIN_WAITLIST_APPLICATION_LANGUAGES_HINT        = "Languages spoken at home (list)."
  ADMIN_WAITLIST_APPLICATION_LANGUAGES_PLACEHOLDER = "English, Italian"

  ADMIN_WAITLIST_APPLICATION_SPECIAL_NEEDS_LABEL   = "Special Needs"
  ADMIN_WAITLIST_APPLICATION_SPECIAL_NEEDS_HINT    = "If person has special needs please list them here."
  ADMIN_WAITLIST_APPLICATION_SPECIAL_NEEDS_PLACEHOLDER = "None"

  ADMIN_WAITLIST_APPLICATION_CULTURAL_NEEDS_LABEL  = "Cultural Needs"
  ADMIN_WAITLIST_APPLICATION_CULTURAL_NEEDS_HINT   = "If person has cultural needs, please list them."
  ADMIN_WAITLIST_APPLICATION_CULTURAL_NEEDS_PLACEHOLDER = "None"

end #module
