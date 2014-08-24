Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: :rails_admin

  mount Quantity::Engine => '/', as: :quantity
end
