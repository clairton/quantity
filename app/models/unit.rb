class Unit < ActiveRecord::Base
  belongs_to :type
  validates :name, :symbol, presence: true, uniqueness: true
  validates :type, presence: true

  def to_s
    try :symbol
  end
end
