class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.belongs_to :user
      t.string :name
      t.text :summary
      t.text :content
      t.string :photo_url
      
      t.timestamps
    end

    add_index :entries, :name
    add_index :entries, :updated_at
  end
end
