class Child < ActiveRecord::Base
  belongs_to :family, polymorphic: true
end
