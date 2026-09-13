class CreateAttendees < ActiveRecord::Migration[7.1]
  def change
    create_table :attendees do |t|
      t.references :event, null: false, foreign_key: true
      t.references :user, foreign_key: true # null: false はつけない
      t.bigint :confirmed_candidate_id
      t.string :parent_name, null: false
      t.string :child_name, null: false
      t.string :grade_class, null: false
      t.string :sibling_info
      t.text :note

      t.timestamps
    end

    add_foreign_key :attendees, :candidates, column: :confirmed_candidate_id
    add_index :attendees, :confirmed_candidate_id
  end
end