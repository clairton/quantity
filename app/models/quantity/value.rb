module Quantity
  class Value < ActiveRecord::Base
    include Quantity::Parseable
    attr_accessor :string
    belongs_to :unit, inverse_of: :values

    validates :amount, numericality: true
    validates :unit, presence: true

    # def initialize(options={})
    #   if options['string']
    #     options.merge Unit.parse(options)
    #   end
    #   super(options)
    # end

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

    def self.parse(string)
      Unit.select(:id, :symbol).each do |unit|
        regexs = [unit.to_regex(before: '^'), unit.to_regex(after: '$')]
        regexs.each do |regex|
          if string =~ regex
            amount = string.sub(regex, '').strip
            hash = Value.new(amount: amount, unit: unit).attributes
            hash['unit'] = unit.attributes
            return hash
          end
        end
      end
    end
  end
end
