module Quantity
  class Ratio < ActiveRecord::Base
    belongs_to :origin, class: Unit, inverse_of: :origins
    belongs_to :destiny, class: Unit, inverse_of: :destinies

    validates :formula, :destiny, :origin, :enable, presence: true

    validate :formulable

    def to(x)
      eval formula
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
