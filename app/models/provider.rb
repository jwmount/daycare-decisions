class Provider < ActiveRecord::Base

  belongs_to :company
  after_initialize :set_defaults
  before_save :set_address
  serialize :address

  #has_many :waitlist_applications
  has_and_belongs_to_many :guardians

  
  # polymorphs
  has_many  :addresses, 
            :as => :addressable

  has_many :certs, 
           :as => :certifiable 
           #:autosave => true, 
           #:dependent => :destroy

  has_many :rolodexes, 
           :as => :rolodexable

  has_many :services, 
           :as => :serviceable

  accepts_nested_attributes_for :addresses, :allow_destroy => true
  accepts_nested_attributes_for :certs, :allow_destroy => true
  accepts_nested_attributes_for :rolodexes, :allow_destroy => true
  accepts_nested_attributes_for :services, :allow_destroy => true

  scope :alphabetically, order("full_name ASC")


  #
  # V A L I D A T I O N S
  #

  validates_presence_of :name, :uniqueness => true
  # NPS_rating seems to be 1...3, so 0 is default for now.
  #validates :NQS_rating,
  #  :numericality => { :only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 3}


 # Best practice in Rails is set defaults here and not in database
  def set_defaults
    unless persisted?    
      self.address   ||= {}
    end
  end

  def set_address
    unless self.addresses.nil?
      self.address[:street] = self.addresses[0].street
      self.address[:locality] = self.addresses[0].locality
      self.address[:post_code] = self.addresses[0].post_code
      self.address[:state]     = self.addresses[0].state
      self.address[:country]   = self.addresses[0].country
      self.address[:latitude]  = self.addresses[0].latitude
      self.address[:longitude] = self.addresses[0].longitude
    end
  end
end


