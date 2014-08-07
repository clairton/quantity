module Quantity
  class Type < ActiveRecord::Base
    has_many :units, inverse_of: :type
    validates :name, presence: true, uniqueness: true
  end
end
