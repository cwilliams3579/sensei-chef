class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  before_create do
   self.admin = false #assuming there is an admin field with a boolean value
  end

  def admin?
    self.admin
  end

  def full_name
    self.first_name + " " + self.last_name
  end
end
