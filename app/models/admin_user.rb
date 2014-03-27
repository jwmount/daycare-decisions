class AdminUser < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :role
    
#  after_create { |admin| admin.send_reset_password_instructions }

  scope :alphabetically, order("email ASC")

  def password_required?
    new_record? ? false : super
  end


end
