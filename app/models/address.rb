class Address < ActiveRecord::Base

  after_initialize :set_defaults
  
  belongs_to :addressable, polymorphic: true
  
  # add geocodes on insertion, c.f. http://www.rubygeocoder.com/
  # and https://github.com/alexreisner/geocoder
  # Note, you can also batch them with: $ rake geocode:all CLASS=Address
  # or $ rake geocode:all CLASS=Address SLEEP=0.25 BATCH=100
  # after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }
  
  # The following works and only fires if address is present and has changed since
  # last save, or has never been saved.  Do you need to code address_changed? to use
  # selective method?  There is none now.
  # http://stackoverflow.com/questions/12034179/using-after-validation-with-an-if-or-clause
  # after_validation :geocode, if: ->(address){ address.present? and address.address_changed? }
 
  geocoded_by :full_address
  after_validation :geocode

  def XXfull_address
    [street, locality, state, post_code].compact.join(', ')
  end

  def full_address
    addr = []
    [street, locality, state, post_code].each do |item|
      addr << item unless item.nil?
    end
    addr.compact.join(', ')
  end



 # Best practice in Rails is set defaults here and not in database
  def set_defaults
    unless persisted?    
      self.country ||= 'Australia'
    end
  end
 

end
