class Cert < ActiveRecord::Base

  belongs_to :certifiable, polymorphic: true

end
