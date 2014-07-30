class Type < ActiveRecord::Base
  has_many :units
  validates :name, presence: true, uniqueness: true
end
