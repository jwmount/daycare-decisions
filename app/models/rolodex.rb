class Rolodex < ActiveRecord::Base


  belongs_to :rolodexable, :polymorphic => true

end
