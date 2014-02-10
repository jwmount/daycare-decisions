class Cert < ActiveRecord::Base
  belongs_to :person, polymorphic: true
  belongs_to :company, polymorphic: true
  belongs_to :provider, polymorphic: true
  belongs_to :agency, polymorphic: true
end
