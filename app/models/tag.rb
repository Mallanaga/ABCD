# == Schema Information
#
# Table name: tags
#
#  id            :integer          not null, primary key
#  taggable_type :string(255)
#  taggable_id   :integer
#  category_id   :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Tag < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :taggable, polymorphic: true
  belongs_to :category

end
