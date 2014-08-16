module Quantity
  class RatioSameUnitType < ActiveModel::Validator
    def validate(ratio)
      if !ratio.destiny.nil? and !ratio.origin.nil?
        unless ratio.destiny.type == ratio.origin.type
          message = "Origin type: '#{ratio.origin.type}' and Destiny type: '#{ratio.destiny.type}' must be same"
          ratio.errors.add(:destiny, message)
          ratio.errors.add(:origin, message)
          ratio.destiny.errors.add(:type, message)
          ratio.origin.errors.add(:type, message)
        end
      end
    end
  end
end
