module Quantity
  class RatioSameUnit < ActiveModel::Validator
    def validate(ratio)
      if !ratio.destiny.nil? and !ratio.origin.nil?
        if ratio.destiny == ratio.origin
          message = "Origin and Destiny are same unit '#{ratio.destiny.type}'"
          ratio.errors.add(:destiny, message)
          ratio.errors.add(:origin, message)
        end
      end
    end
  end
end
