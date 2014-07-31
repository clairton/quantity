class Ratio < ActiveRecord::Base
  belongs_to :origin, class_name: 'Unit'
  belongs_to :destiny, class_name: 'Unit'

  validates :destiny, :origin, :formula, :enable, presence: true
end
