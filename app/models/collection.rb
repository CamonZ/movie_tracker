class Collection < ApplicationRecord

  has_and_belongs_to_many :movies, uniq: true

  validates_presence_of :title, :description

end
