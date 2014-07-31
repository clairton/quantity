class CreateRatios < ActiveRecord::Migration
  def change
    create_table :ratios do |t|
      t.integer :origin
      t.integer :destiny
      t.formula :value
    end
  end
end
