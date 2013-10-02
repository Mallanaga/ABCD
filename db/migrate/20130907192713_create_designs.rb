class CreateDesigns < ActiveRecord::Migration
  def change
    create_table :designs do |t|
      t.string :name
      t.text :content
      t.string :url
      t.string :photo_url
      t.date :published_at

      t.timestamps
    end

    add_index :designs, :name
    add_index :designs, :published_at
  end
end
