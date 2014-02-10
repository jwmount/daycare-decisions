class Address < ActiveRecord::Base
  belongs_to :provider, polymorphic: true
  belongs_to :person, polymorphic: true
  belongs_to :company, polymorphic: true
end
