class CreateInvites < ActiveRecord::Migration[5.2]
  def change
    create_table :invites do |t|
      t.references :team, foreign_key: true
      t.string :email
      t.string :token
      t.boolean :visualized, default: false
      t.boolean :accepted, default: false

      t.timestamps
    end
    add_index :invites, :token, unique: true
  end
end
