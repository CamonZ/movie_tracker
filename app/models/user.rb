class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  validates_presence_of :email, :password
  validates_uniqueness_of :email, case_sensitive: false
end
