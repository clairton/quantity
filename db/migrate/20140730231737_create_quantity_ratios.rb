class CreateQuantityRatios < ActiveRecord::Migration
  def change
    create_table :quantity_ratios do |t|
      t.integer :origin_id, null: false, index: true
      t.integer :destiny_id, null: false, index: true
      t.string :formula, null: false, index: true
      t.boolean :enable, null: false, default: true, index: true

      t.timestamps
    end
    add_index :quantity_ratios, [:origin_id, :destiny_id], unique: true
  end
end
