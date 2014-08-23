require 'enumerize'

module Quantity
  class Unit < ActiveRecord::Base
    extend Enumerize
    enumerize :position, in: [:after, :before]


    belongs_to :type, validate: true, inverse_of: :units
    has_many :values, inverse_of: :unit
    has_many :origins, inverse_of: :origin, class_name: 'Ratio', foreign_key: 'origin_id'
    has_many :destinies, inverse_of: :destiny, class_name: 'Ratio', foreign_key: 'destiny_id'

    validates :name, :symbol, presence: true, uniqueness: true
    validates :type, :position, presence: true
    validates :position, inclusion: {in: Unit.position.values}

    after_initialize :default_values

    scope :by_symbol, ->(symbol){where(symbol: symbol)}

    @@formats = {
      after: Proc.new {|amount, symbol|
        "#{amount} #{symbol}"
      },
      before: Proc.new {|amount, symbol|
        "#{symbol} #{amount}"
      }
    }

    def format(value)
      @@formats[position.to_sym].call(value, symbol)
    end

    def to_s
      try :symbol
    end

    def self.parse(string)
      by_symbol(string).first
    end

    def to_regex(options = {})
      options[:before] ||= ''
      options[:after] ||= ''
      /#{options[:before]}#{Regexp.quote(symbol)}#{options[:after]}/
    end

    private
    def default_values
      self.position ||= :after
    end
  end
end
