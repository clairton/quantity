module Quantity
  class Unit < ActiveRecord::Base
    belongs_to :type, validate: true, inverse_of: :units
    has_many :values, inverse_of: :unit
    has_many :origins, inverse_of: :origin, class: Ratio
    has_many :destinies, inverse_of: :destiny, class: Ratio

    validates :name, :symbol, presence: true, uniqueness: true
    validates :type, presence: true
    validates :position, inclusion: {in: [:after, :before]}

    after_initialize :default_values

    def to_s
      try :symbol
    end

    private
    def default_values
      self.position ||= :after
    end
  end
end
