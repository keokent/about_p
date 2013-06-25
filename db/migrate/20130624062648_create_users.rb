class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :github_uid
      t.string :name
      t.integer :section_id
      t.string :job_type
      t.string :irc_name
      t.string :nickname
      t.string :birthday
      t.text :birthplace
      t.text :background
      t.text :ppb_carrier
      t.text :hometown
      t.text :hobby
      t.text :favorite_food    
      t.text :favorite_book
      t.text :club    
      t.text :strong_point
      t.text :free_space
      t.timestamps
    end

    add_index :users, :id
    add_index :users, :github_uid
    add_index :users, :nickname
    add_index :users, :irc_name
  end
end
