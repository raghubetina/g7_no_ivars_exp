# Copy this file into your spec/support folder; create one if you don't have it.
# https://github.com/firstdraft/increasing_random/blob/master/increasing_random.rb

require Rails.root.join("spec", "support", "increasing_random.rb")

FactoryGirl.define do
  factory :photo do
    sequence(:id, IncreasingRandom.new) { |n| n.value }
    sequence(:source, IncreasingRandom.new) { |n| "Some fake source #{n}" }
    sequence(:caption, IncreasingRandom.new) { |n| "Some fake caption #{n}" }
  end
end
