require "rails_helper"

RSpec.describe Post, type: :model do
  describe "associations" do
    it { should belong_to(:user) }
    it { should have_many(:likes).dependent(:destroy) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many_attached(:photos) }
  end

  describe "validations" do
    it { should validate_length_of(:caption).is_at_most(2200) }
  end
end
