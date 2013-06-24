class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.string :name
      t.blob :icon

      t.timestamps
    end
  end
end
