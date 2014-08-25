require 'test_helper'

module Quantity
  class RatioSameUnitType < ActiveSupport::TestCase
    fixtures 'quantity/types', 'quantity/units', 'quantity/ratios'

    test 'same unit' do
      lt = quantity_units(:lt)
      ratio = Ratio.new(origin: lt, destiny: lt, formula: 'x')
      assert ratio.invalid?
      assert ratio.errors.has_key? :destiny
      assert ratio.errors.has_key? :origin
    end
  end
end
