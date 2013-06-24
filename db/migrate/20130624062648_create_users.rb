class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :nickname
      t.string :irc_name
      t.blob   :face_image
      t.integer :section_id
      t.integer :job_type
      t.string :github_id
      t.string :birthday
      t.text :backgroud
      t.text :hobby
      t.text :free_space
      t.timestamps
    end
  end
end
