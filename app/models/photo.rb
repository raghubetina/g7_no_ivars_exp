# == Schema Information
#
# Table name: photos
#
#  id         :integer          not null, primary key
#  source     :string
#  caption    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Photo < ApplicationRecord
end
