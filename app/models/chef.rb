class Chef < ApplicationRecord
  has_secure_password
  searchkick

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :chefname, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
  validates :chefname, presence: true, length: { in: 2..20 }
  validates :password, presence: true, length: { in: 6..20 }

  has_many :recipes


  before_save do
   self.email.downcase!
   self.chefname.capitalize!
 end
end
