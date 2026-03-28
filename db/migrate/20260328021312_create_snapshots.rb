class CreateSnapshots < ActiveRecord::Migration[8.1]
  def change
    create_table :snapshots do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :commits_count
      t.integer :repos_count
      t.jsonb :languages
      t.date :date

      t.timestamps
    end
  end
end
