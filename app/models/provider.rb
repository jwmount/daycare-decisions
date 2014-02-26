class Provider < ActiveRecord::Base

  belongs_to :company

  #has_many :waitlist_applications
  has_and_belongs_to_many :guardians

  
  # polymorphs
  has_many  :addresses, 
            :as => :addressable, 
            :autosave => true, 
            :dependent => :destroy

  has_many :certs, 
           :as => :certifiable, 
           :autosave => true, 
           :dependent => :destroy

  has_many :rolodexes, 
           :as => :rolodexable, 
           :autosave => true, 
           :dependent => :destroy

  accepts_nested_attributes_for :addresses
  accepts_nested_attributes_for :certs
  accepts_nested_attributes_for :rolodexes

  # NPS_rating seems to be 1...3, so 0 is default for now.
  validates :NQS_rating,
    :numericality => { :only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 3}

  def add_to_list! hot
    puts hot
    true
  end

end
