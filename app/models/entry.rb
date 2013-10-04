# == Schema Information
#
# Table name: entries
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  name       :string(255)
#  summary    :text
#  content    :text
#  photo_url  :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Entry < ActiveRecord::Base
#  extend FriendlyId
#  friendly_id :title

  attr_accessible :user_id, :name, :summary, :content,
                  :photo_url, :category_tokens
  attr_reader :category_tokens

  belongs_to :user
  has_many :tags, as: :taggable, dependent: :destroy
  has_many :categories, through: :tags

  validates :name, presence: true
  validates :content, presence: true

  default_scope order: 'entries.updated_at DESC'

  def category_tokens=(tokens)
    self.category_ids = Category.ids_from_tokens(tokens)
  end

  def first_image
    doc = Nokogiri::HTML(open("http://localhost:3000/blog/#{self.id}"))
    image = doc.css('.well img')[0] ? doc.css('.well img')[0]['src'] : nil
    self.update_attribute(:photo_url, image)
  end
end
