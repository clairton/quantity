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

    test 'to_s' do
      value = Value.new(amount: 1.0, unit: quantity_units(:km))
      assert_equal '1.0 km', value.to_s
    end

    test 'as' do
      km = Value.new(amount: 1.0, unit: quantity_units(:km))
      mt = km.as(quantity_units(:mt))
      assert_equal 1000, mt.amount
      assert_equal 'mt', mt.unit.symbol
    end

    test 'call as when ratio not found' do
      assert_raise ActiveRecord::RecordNotFound do
        km = Value.new(amount: 1.0, unit: quantity_units(:hr))
        mt = km.as(quantity_units(:mn))
      end
    end

    test 'call as with self unit' do
      unit = quantity_units(:hr)
      value = Value.new(amount: 1.0, unit: unit)
      assert_equal value, value.as(unit)
    end

    test 'parse reais' do
      value = Value.parse('R$ 1.01')
      assert_equal 1.01, value['amount']
      assert_equal 'R$', Unit.find(value['unit_id']).symbol
    end

    test 'parse duzia' do
      value = Value.parse('6 dz')
      assert_equal 6, value['amount']
      assert_equal 'dz', Unit.find(value['unit_id']).symbol
    end

    test 'create from parseable string' do
      value = Value.create('10 un')
      assert_equal 10, value['amount']
      assert_equal 'un', Unit.find(value['unit_id']).symbol
    end

    test 'create from not exist unit' do
      assert_raise ActiveRecord::RecordNotFound do
        Value.create('15 %')
      end
    end
  end
end
