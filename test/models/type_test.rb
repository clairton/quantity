require 'test_helper'

class TypeTest < ActiveSupport::TestCase
  test 'presence of name' do
    type = Type.new(name: nil)
    assert type.invalid?
  end

  test 'uniqueness name' do
    type = Type.new(name: types(:tempo).name)
    assert type.invalid?
  end

  test 'valid' do
    type = Type.new(name: 'Dureza')
    assert type.valid?
  end
end
