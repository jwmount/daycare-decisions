class Certificate < ActiveRecord::Base

  has_many :certs, 
           :as => :certifiable, 
           :autosave => true, 
           :dependent => :destroy

  accepts_nested_attributes_for :certs

  scope :alphabetically, order("name ASC")
    
end
