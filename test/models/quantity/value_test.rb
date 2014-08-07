require 'test_helper'
module Quantity
  class ValueTest < ActiveSupport::TestCase
    fixtures 'quantity/types', 'quantity/units', 'quantity/ratios', 'quantity/values'
    test 'presence of amout' do
      value = Value.new(amount: nil, unit: quantity_units(:real))
      assert value.invalid?
      assert value.errors.has_key? :amount
    end

    test 'presence of unit' do
      value = Value.new(amount: 1.0, unit: nil)
      assert value.invalid?
      assert value.errors.has_key? :unit
    end

    test 'numericality of amount' do
      value = Value.new(amount: 'abc', unit: quantity_units(:hr))
      assert value.invalid?
      assert value.errors.has_key? :amount
    end

    test 'valid' do
      value = Value.new(amount: 1.0, unit: quantity_units(:km))
      assert value.valid?
    end
  end
end
