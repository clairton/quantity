module Quantity
  class Ratio < ActiveRecord::Base
    belongs_to :origin, class: Unit, inverse_of: :origins
    belongs_to :destiny, class: Unit, inverse_of: :destinies

    validates :formula, :destiny, :origin, :enable, presence: true

    validate :formulable

    def to(x)
      eval formula
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
