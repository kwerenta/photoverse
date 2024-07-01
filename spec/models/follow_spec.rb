require "rails_helper"

RSpec.describe Follow, type: :model do
  describe "associations" do
    it { should belong_to(:follower).class_name("User").counter_cache(:followings_count) }
    it { should belong_to(:following).class_name("User").counter_cache(:followers_count) }
  end

  describe "validations" do
    it { should validate_uniqueness_of(:follower_id).scoped_to(:following_id) }
  end
end
