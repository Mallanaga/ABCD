class CreateDesigns < ActiveRecord::Migration
  def change
    create_table :designs do |t|
      t.string :name
      t.text :description
      t.string :url
      t.string :photo_url
      t.date :published_at

      t.timestamps
    end
  end
end
