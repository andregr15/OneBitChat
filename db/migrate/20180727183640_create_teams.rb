class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.string :slug
      t.references :user_id, foriegn_key: true

      t.timestamps
    end
  end
end
