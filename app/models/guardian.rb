class Guardian < ActiveRecord::Base

  has_many :waitlist_applications
  #has_many :providers
  has_and_belongs_to_many :providers
  
  # polymorphs
  has_many  :addresses, 
            :as        => :addressable, 
            :autosave  => true, 
            :dependent => :destroy

  has_many :rolodexes, 
           :as         => :rolodexable, 
           :autosave   => true, 
           :dependent  => :destroy

  accepts_nested_attributes_for :addresses
  accepts_nested_attributes_for :rolodexes

  scope :alphabetically, order("handle ASC")
  
  #
  # V A L I D A T I O N S    V A L I D A T I O N S    V A L I D A T I O N S    V A L I D A T I O N S
  #
  validates_presence_of :family_name



  def full_name
    [self.first_name, self.family_name].join(' ')
  end

end
