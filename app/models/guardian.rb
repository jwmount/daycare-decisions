class Guardian < ActiveRecord::Base

  has_many :waitlist_applications
  has_many :providers

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



  def full_name
    [self.first_name, self.family_name].join(' ')
  end

end
