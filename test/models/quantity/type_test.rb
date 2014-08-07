require 'test_helper'
module Quantity
  class TypeTest < ActiveSupport::TestCase
    fixtures 'quantity/types'
    test 'presence of name' do
      type = Type.new(name: nil)
      assert type.invalid?
      assert type.errors.has_key? :name
    end

    test 'uniqueness name' do
      type = Type.new(name: quantity_types(:tempo).name)
      assert type.invalid?
      assert type.errors.has_key? :name
    end

    test 'valid' do
      type = Type.new(name: 'Dureza')
      assert type.valid?
    end
  end
end
