class WaitlistApplication < ActiveRecord::Base

  belongs_to :guardian, :dependent => :destroy
  belongs_to :provider, :dependent => :destroy
  
end
