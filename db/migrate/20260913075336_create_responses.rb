class CreateResponses < ActiveRecord::Migration[7.1]
  def change
    create_table :responses do |t|
      t.references :attendee, null: false, foreign_key: true
      t.references :candidate, null: false, foreign_key: true
      t.integer :status, null: false, default: 0

      t.timestamps
    end
    add_index :responses, [:attendee_id, :candidate_id], unique: true
  end
end