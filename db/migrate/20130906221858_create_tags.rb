class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.belongs_to :entry
      t.belongs_to :category
      
      t.timestamps
    end

    add_index :tags, :entry_id
    add_index :tags, :category_id
  end
end
