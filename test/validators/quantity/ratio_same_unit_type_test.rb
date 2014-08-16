require 'test_helper'

module Quantity
  class RatioSameUnitTypeTest < ActiveSupport::TestCase
    fixtures 'quantity/types', 'quantity/units', 'quantity/ratios'

    test 'two types' do
      ratio = Ratio.create(destiny: quantity_units(:hr), origin: quantity_units(:kg))
      assert ratio.invalid?
      assert ratio.errors.has_key? :origin
      assert ratio.origin.errors.has_key? :type
      assert ratio.errors.has_key? :destiny
      assert ratio.destiny.errors.has_key? :type
    end
  end
end
