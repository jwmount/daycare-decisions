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
  ADMIN_PROVIDER_NAME_LABEL              = "Provider Name"
  ADMIN_PROVIDER_NAME_HINT               = "Provider name"
  ADMIN_PROVIDER_NAME_PLACEHOLDER        = "ABC Child Care"

  ADMIN_PROVIDER_CARE_HINT               = "Type of care provided."
  ADMIN_PROVIDER_CARE_PLACEHOLDER        = "Long Day"

  ADMIN_PROVIDER_NQS_RATING_LABEL        = "NQS rating"
  ADMIN_PROVIDER_NQS_RATING_PLACEHOLDER  = "1...3"
  ADMIN_PROVIDER_NQS_RATING_HINT         = "describe what an NQS rating means"

  ADMIN_PROVIDER_LANGUAGE_LABEL          = "Languages Available"
  ADMIN_PROVIDER_LANGUAGE_PLACEHOLDER   = "English"
  ADMIN_PROVIDER_LANGUAGE_HINT          = "Language options offered"

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

  ADMIN_ROLODEX_KIND_LABEL           = "Phone Number, address, etc."            
  ADMIN_ROLODEX_KIND_HINT            = "Number, address, etc.  For example, 514 509-8381, or info@somecompany.com."
  ADMIN_ROLODEX_KIND_PLACEHOLDER     = "Phone number, email address, ..."

  ADMIN_ROLODEX_WHEN_TO_USE_LABEL            = "Priority of use."
  ADMIN_ROLODEX_WHEN_TO_USE_HINT             = "Order prefered."
  ADMIN_ROLODEX_WHEN_TO_USE_PLACEHOLDER      = "1..9"

#
# Roles
#
# none



end
