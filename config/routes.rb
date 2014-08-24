Quantity::Engine.routes.draw do
  scope 'quantity' do
    resources :values, :units, :types, :ratios
  end
end
