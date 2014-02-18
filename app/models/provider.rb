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

def languages
  [ 
    'Arabic',
    'Cantonese',
    'French',
    'German',
    'Hebrew',
    'Italian',
    'Mandarin',
    'Spanish',
    'Other'
  ]
end


# Care Categories
  # current child care enquiry may find they need to provide a rebate to nannies and aupairs, 
  # we need to scope the flexibility in the major build to include this)
def HOLDcare #_categories
 [
  "Long Day Care",
  "Occasional Care"
  ]
  end

end
