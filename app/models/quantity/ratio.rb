module Quantity
  class Ratio < ActiveRecord::Base
    belongs_to :origin, class_name: 'Unit', inverse_of: :origins, foreign_key: 'origin_id'
    belongs_to :destiny, class_name: 'Unit', inverse_of: :destinies, foreign_key: 'destiny_id'

    validates :formula, :destiny, :origin, :enable, presence: true
    validate :formulable
    validates_with RatioSameUnitType
    validates_with RatioSameUnit

    def to(x)
      eval formula
    end

    def to_s
      "#{try :origin} -> #{try :destiny}"
    end

    def self.for(origin, destiny)
      ratio = find_by(origin: origin, destiny: destiny)
      if ratio.nil?
        message = "Ratio not found for origin: '#{origin}' and destiny: '#{destiny}'"
        raise ActiveRecord::RecordNotFound, message
      end
      ratio
    end

  private
    def formulable
      begin
        to(1)
      rescue
        errors.add(:formula, :invalid)
      end
    end
  end
end
