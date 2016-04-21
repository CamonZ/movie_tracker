class Collection < ApplicationRecord

  has_and_belongs_to_many :movies, uniq: true
  belongs_to :user

  validates_presence_of :title, :description, :user

end
