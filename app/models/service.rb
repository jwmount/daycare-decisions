class Service < ActiveRecord::Base

  belongs_to :rolodexable, :polymorphic => true

end
