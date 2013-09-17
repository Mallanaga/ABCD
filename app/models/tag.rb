class Tag < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :taggable, polymorphic: true
  belongs_to :category

end