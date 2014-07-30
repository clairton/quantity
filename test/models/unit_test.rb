require 'test_helper'

class UnitTest < ActiveSupport::TestCase
  test 'presence of name' do
    unit = Unit.new(name: nil, symbol: 'R$$', type: types(:monetario))
    assert unit.invalid?
  end

  test 'uniqueness name' do
    unit = Unit.new(name: units(:km).name, symbol: 'ML', type: types(:distancia))
    assert unit.invalid?
  end

  test 'presence of symbol' do
    unit = Unit.new(name: 'Dolares', symbol: nil, type: types(:monetario))
    assert unit.invalid?
  end

  test 'uniqueness symbol' do
    unit = Unit.new(name: 'Guaranis', symbol: 'R$', type: types(:monetario))
    assert unit.invalid?
  end

  test 'presence of type' do
    unit = Unit.new(name: 'Dolares', symbol: 'U$', type: nil)
    assert unit.invalid?
  end

  test 'valid' do
    unit = Unit.new(name: 'Minuto', symbol: 'Mn', type: types(:tempo))
    assert unit.valid?
  end

  test 'to_s' do
    assert_equal 'KM', units(:km).to_s
  end
end
