class Provider < ActiveRecord::Base


  # polymorphs
  has_many  :addresses, 
            :as => :addressable, 
            :autosave => true, 
            :dependent => :destroy

  has_many :certs, 
           :as => :certifiable, 
           :autosave => true, 
           :dependent => :destroy

  has_many :identifiers, 
           :as => :identifiable, 
           :autosave => true, 
           :dependent => :destroy

  accepts_nested_attributes_for :addresses
  accepts_nested_attributes_for :certs
  accepts_nested_attributes_for :identifiers

end
