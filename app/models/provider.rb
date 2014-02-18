class Provider < ActiveRecord::Base

  belongs_to :company

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

  validates :NQS_rating,
    :numericality => { :only_integer => true, :greater_than_or_equal_to => 1, :less_than_or_equal_to => 3}



end
