class Cert < ActiveRecord::Base

  belongs_to :certificate
  belongs_to :certifiable, :polymorphic => true


end
