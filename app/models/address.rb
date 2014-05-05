class Address < ActiveRecord::Base

  after_initialize :set_defaults

  belongs_to :addressable, polymorphic: true
  
  # add geocodes on insertion, c.f. http://www.rubygeocoder.com/
  # Note, you can also batch them with $ rake geocode:all CLASS=Address
  # after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }
  after_validation :geocode, if: ->(address){ address.address.present? and address.address_changed? }
  #:after_validation :geocode
  geocoded_by :address

  def address
    [street, locality, state, post_code].compact.join(', ')
  end

  def address_changed?
    false
  end

 # Best practice in Rails is set defaults here and not in database
  def set_defaults
    unless persisted?    
      self.country ||= 'Australia'
    end
  end
 
end
