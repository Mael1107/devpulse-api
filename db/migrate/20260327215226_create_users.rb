class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :github_uid
      t.string :username
      t.string :avatar_url
      t.string :access_token

      t.timestamps
    end
  end
end
