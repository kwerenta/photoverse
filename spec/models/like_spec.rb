require "rails_helper"

RSpec.describe Like, type: :model do
  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:likeable) }
  end

  describe "validations" do
    subject { create(:like) }

    it { should validate_uniqueness_of(:user_id).scoped_to(%i[likeable_id likeable_type]) }
  end
end
