class Provider < ActiveRecord::Base

  belongs_to :company

  #has_many :waitlist_applications
  has_and_belongs_to_many :guardians

  
  # polymorphs
  has_many  :addresses, 
            :as => :addressable

  has_many :certs, 
           :as => :certifiable 
           #:autosave => true, 
           #:dependent => :destroy

  has_many :rolodexes, 
           :as => :rolodexable

  has_many :services, 
           :as => :serviceable

  accepts_nested_attributes_for :addresses, :allow_destroy => true
  accepts_nested_attributes_for :certs, :allow_destroy => true
  accepts_nested_attributes_for :rolodexes, :allow_destroy => true
  accepts_nested_attributes_for :services, :allow_destroy => true

  scope :alphabetically, order("full_name ASC")

  #
  # V A L I D A T I O N S
  #
  validates_presence_of :name, :uniqueness => true
  # NPS_rating seems to be 1...3, so 0 is default for now.
  #validates :NQS_rating,
  #  :numericality => { :only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 3}

  def XXadd_to_list! hot
    puts hot
    true
  end

  # Concordance -- when 'The Name Needed', try ['this one', 'or this one',...]
  def alternate_keys key
    case key

      when 'Legal Name'
        ['Provider Legal Name']
      when 'Name'
        ['Service Name']
      when 'Approved Places'
        ['Number Of Approved Places']
      when 'Approval Granted On'
        ['Service Approval Granted Date']
      when 'Quality Area Rating 1'
        ['Quality Area 1 Rating']
      when 'Quality Area Rating 2'
        ['Quality Area 2 Rating']
      when 'Quality Area Rating 3'
        ['QualityArea3Rating']
      when 'Quality Area Rating 4'
        ['QualityArea4Rating']
      when 'Quality Area Rating 5'
        ['QualityArea5Rating']
      when 'Quality Area Rating 6'
        ['QualityArea6Rating']
      when 'Quality Area Rating 7'
        ['QualityArea7Rating']
      when 'Overall Rating' 
        ['OverallRating']
      when 'Online Enrolment'
        ['Online enrollment']
      when 'Security'
        ['Security Access']
      else
        [key]
    end
  end

end
