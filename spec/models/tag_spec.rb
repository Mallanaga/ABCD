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

require 'spec_helper'

describe Tag do
  pending "add some examples to (or delete) #{__FILE__}"
end
