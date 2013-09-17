class Entry < ActiveRecord::Base
#  extend FriendlyId
#  friendly_id :title

  attr_accessible :user_id, :title, :summary, :content, :category_tokens
  attr_reader :category_tokens

  belongs_to :user
  has_many :tags, as: :taggable, dependent: :destroy
  has_many :categories, through: :tags

  validates :content, presence: true

  default_scope order: 'entries.updated_at DESC'

  def category_tokens=(tokens)
    self.category_ids = Category.ids_from_tokens(tokens)
  end
end
