class CreateTypes < ActiveRecord::Migration
  def change
    create_table :types do |t|
      t.string :name, null: false, length: 25, index: true, unique: true
    end
  end
end
