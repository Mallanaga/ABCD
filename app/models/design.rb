# == Schema Information
#
# Table name: designs
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  content      :text
#  url          :string(255)
#  photo_url    :string(255)
#  published_at :date
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Design < ActiveRecord::Base
  attr_accessible :name, :content, :url, :photo_url,
                  :published_at, :category_tokens
  attr_reader :category_tokens

  has_many :tags, as: :taggable, dependent: :destroy
  has_many :categories, through: :tags

  validates :name, presence: true
  validates :content, presence: true

  default_scope order: 'designs.published_at DESC'

  def category_tokens=(tokens)
    self.category_ids = Category.ids_from_tokens(tokens)
  end

  def first_image
    @doc = Nokogiri::HTML(open("http://localhost:3000/designs/#{self.id}"))
    image = @doc.css('.well img')[0] ? @doc.css('.well img')[0]['src'] : nil
    self.update_attribute(:photo_url, image)
  end
end
