class Address < ActiveRecord::Base

  belongs_to :addressable, polymorphic: true, dependent: :destroy

end
