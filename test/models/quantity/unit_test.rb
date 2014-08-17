require 'test_helper'
module Quantity
  class UnitTest < ActiveSupport::TestCase
    fixtures 'quantity/types', 'quantity/units'
    test 'presence of name' do
      unit = Unit.new(name: nil, symbol: 'R$$', type: quantity_types(:monetario))
      assert unit.invalid?
      assert unit.errors.has_key? :name
    end

    test 'uniqueness name' do
      unit = Unit.new(name: quantity_units(:km).name, symbol: 'ML', type: quantity_types(:distancia))
      assert unit.invalid?
      assert unit.errors.has_key? :name
    end

    test 'presence of symbol' do
      unit = Unit.new(name: 'Dolares', symbol: nil, type: quantity_types(:monetario))
      assert unit.invalid?
      assert unit.errors.has_key? :symbol
    end

    test 'presence of position' do
      unit = Unit.new(name: 'Milisegundos', symbol: 'Mn', type: Type.first)
      unit.position= nil
      assert unit.invalid?
      assert unit.errors.has_key? :position
    end

    test 'inclusion in position' do
      unit = Unit.new(name: 'Milisegundos', symbol: 'Mn', type: Type.first)
      unit.position = :between
      assert unit.invalid?
      assert unit.errors.has_key? :position
    end

    test 'uniqueness symbol' do
      unit = Unit.new(name: 'Guaranis', symbol: 'R$', type: quantity_types(:monetario))
      assert unit.invalid?
      assert unit.errors.has_key? :symbol
    end

    test 'presence of type' do
      unit = Unit.new(name: 'Dolares', symbol: 'U$', type: nil)
      assert unit.invalid?
      assert unit.errors.has_key? :type
    end

    test 'valid' do
      unit = Unit.new(name: 'Milisegundos', symbol: 'Mn', type: Type.first, position: :after)
      assert unit.valid?, unit.errors.first
    end

    test 'to_s' do
      assert_equal 'km', quantity_units(:km).to_s
    end
  end
end
