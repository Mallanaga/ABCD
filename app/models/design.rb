class Design < ActiveRecord::Base
  attr_accessible :name, :description, :url, :photo_url,
                  :published_at, :category_tokens
  attr_reader :category_tokens

  has_many :tags, as: :taggable, dependent: :destroy
  has_many :categories, through: :tags

  validates :name, presence: true

  def category_tokens=(tokens)
    self.category_ids = Category.ids_from_tokens(tokens)
  end
end
