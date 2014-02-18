class Person < ActiveRecord::Base

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


  def self.display_name
    full_name
  end

  def full_name
    [self.first_name, self.last_name].compact.join ' '
  end

end
