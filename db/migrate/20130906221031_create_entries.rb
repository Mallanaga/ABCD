class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.belongs_to :user
      t.string :title
      t.text :summary
      t.text :content
      
      t.timestamps
    end

    add_index :entries, :title
    add_index :entries, :updated_at
  end
end
