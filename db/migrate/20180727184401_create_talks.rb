class CreateTalks < ActiveRecord::Migration[5.2]
  def change
    create_table :talks do |t|
      t.references :user_one_id, references: :user
      t.references :user_two_id, references: :user
      t.references :team, foreign_key: true

      t.timestamps
    end
  end
end
