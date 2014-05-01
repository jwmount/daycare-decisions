class Address < ActiveRecord::Base

  after_validation :geocode
  belongs_to :addressable, polymorphic: true
  geocoded_by :address

  def address
    [street, locality, state, post_code, country].compact.join(', ')
  end

end
