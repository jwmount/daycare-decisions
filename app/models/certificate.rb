class Certificate < ActiveRecord::Base

  has_many :certs, dependent: :destroy

  scope :alphabetically, order("name ASC")
    
  validates :name,          :presence => true

end
