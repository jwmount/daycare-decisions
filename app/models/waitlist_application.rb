class WaitlistApplication < ActiveRecord::Base

  belongs_to :guardian, :dependent => :destroy

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

# 
# V A L I D A T I O N S
#
#
  # V A L I D A T I O N S    V A L I D A T I O N S    V A L I D A T I O N S    V A L I D A T I O N S
  #
  validates_presence_of :lodged_for
  validates :mother_dependents_count, :father_dependents_count, :numericality => {:greater_than_or_equal_to => 0, :less_than => 12}

  # C O N T R A C T  T Y P E  V A L I D A T I O N S  --  I N C O M P L E T E
  # CONTRACT TYPE conditional validations -- given contract type, do we have what we need?
  #
=begin
  with_options :if => :export? do |s|
    s.validates :total_material, 
      :numericality => { :only_integer => true, :greater_than_or_equal_to => 1, :less_than => 500001}
  end
=end  

  def display_name
    full_name
  end

  def full_name
    [self.first_name, self.last_name].compact.join ' '
  end
    
end
