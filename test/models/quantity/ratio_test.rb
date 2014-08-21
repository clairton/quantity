require 'test_helper'
module Quantity
  class RatioTest < ActiveSupport::TestCase
    fixtures 'quantity/types', 'quantity/units', 'quantity/ratios'
    test 'presence of formula' do
      ratio = Ratio.new(origin: quantity_units(:mn), destiny: quantity_units(:sg), enable: true)
      assert ratio.invalid?
      assert ratio.errors.has_key? :formula
    end

    test 'presence of origin' do
      ratio = Ratio.new(destiny: quantity_units(:ml), enable: true, formula: 'x * 1000')
      assert ratio.invalid?
      assert ratio.errors.has_key? :origin
    end

    test 'presence of destiny' do
      ratio = Ratio.new(origin: quantity_units(:lt), enable: true, formula: 'x / 1000')
      assert ratio.invalid?
      assert ratio.errors.has_key? :destiny
    end

    test 'presence of enable' do
      ratio = Ratio.new(origin: quantity_units(:dz), destiny: quantity_units(:un), enable: nil, formula: 'x * 12')
      assert ratio.invalid?
      assert ratio.errors.has_key? :enable
    end

    test 'valid' do
      ratio = Ratio.new(origin: quantity_units(:lt), destiny: quantity_units(:ml), formula: 'x * 1000')
      assert ratio.valid?
    end

    test 'celsius to fahrenheit' do
      ratio = quantity_ratios(:celsius_to_fahrenheit)
      assert_equal 212, ratio.to(100)
    end

    test 'km to mi' do
      ratio = quantity_ratios(:km_to_mi)
      assert_equal 0.621371192237334, ratio.to(1)
    end

    test 'to string' do
      ratio = quantity_ratios(:km_to_mi)
      assert_equal 'km -> mi', ratio.to_s
    end

    test 'for' do
      ratio = Ratio.for(quantity_units(:km), quantity_units(:mi))
      assert !ratio.nil?
    end

    test 'call for when ratio not found' do
      assert_raise ActiveRecord::RecordNotFound do
        Ratio.for(quantity_units(:hr), quantity_units(:mn))
      end
    end
  end
end
