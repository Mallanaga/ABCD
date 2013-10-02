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

require 'spec_helper'

describe Entry do
  pending "add some examples to (or delete) #{__FILE__}"
end
