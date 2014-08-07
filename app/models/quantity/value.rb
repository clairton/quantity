module Quantity
  class Value < ActiveRecord::Base
    belongs_to :unit, inverse_of: :values

    validates :amount, numericality: true
    validates :unit, presence: true
  end
end
