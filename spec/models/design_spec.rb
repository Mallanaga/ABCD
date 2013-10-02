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

require 'spec_helper'

describe Design do
  pending "add some examples to (or delete) #{__FILE__}"
end
