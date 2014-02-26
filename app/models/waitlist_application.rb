class WaitlistApplication < ActiveRecord::Base

  belongs_to :guardian, :dependent => :destroy
  belongs_to :provider, :dependent => :destroy

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
  
end
