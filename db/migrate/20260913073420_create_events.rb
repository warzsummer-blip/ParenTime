class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.text :description
      t.integer :slot_duration, null: false, default: 15
      t.string :token, null: false

      t.timestamps
    end
    add_index :events, :token, unique: true
  end
end