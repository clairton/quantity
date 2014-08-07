class CreateQuantityValues < ActiveRecord::Migration
  def change
    create_table :quantity_values do |t|
      t.decimal :amount, null: false, index: true
      t.integer :unit_id, null: false, index: true
    end
  end
end
