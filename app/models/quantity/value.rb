module Quantity
  class Value < ActiveRecord::Base
    belongs_to :unit, inverse_of: :values

    validates :amount, numericality: true
    validates :unit, presence: true

    def as(unit)
      if self.unit == unit
        return self
      end
      ratio = Ratio.for(self.unit, unit)
      amount = ratio.to(self.amount)
      Value.new(unit: unit, amount: amount)
    end

    def to_s
      unit.format(amount)
    end
  end
end
