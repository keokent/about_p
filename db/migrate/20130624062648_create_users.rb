class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :nickname
      t.string :irc_name
      t.binary   :face_image
      t.integer :section_id
      t.integer :job_type
      t.string :github_id
      t.string :birthday
      t.text :background
      t.text :hobby
      t.text :free_space
      t.timestamps
    end

    add_index :users, :id
    add_index :users, :github_id
    add_index :users, :nickname
    add_index :users, :irc_name
  end
end
