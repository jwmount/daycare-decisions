class Source < ActiveRecord::Base

  belongs_to :sourceable, polymorphic: true

end
