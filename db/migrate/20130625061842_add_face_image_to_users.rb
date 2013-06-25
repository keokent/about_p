class AddFaceImageToUsers < ActiveRecord::Migration
  def change
    add_column :users, :face_image, :string
  end
end
