class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :taggable_type
      t.integer :taggable_id 
      t.belongs_to :category
      
      t.timestamps
    end

    add_index :tags, :category_id
  end
end
