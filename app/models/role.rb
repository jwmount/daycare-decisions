class Role < ActiveRecord::Base

  has_many :admin_users
  
  validates_presence_of :name
  
  scope :alphabetically, order("name ASC")


end
