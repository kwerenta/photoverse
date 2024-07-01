require "rails_helper"

RSpec.describe Comment, type: :model do
  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
    it { should belong_to(:parent).class_name("Comment").optional }
    it {
      should have_many(:replies)
        .class_name("Comment")
        .with_foreign_key(:parent_id)
        .dependent(:destroy)
        .inverse_of(:parent)
    }
  end

  describe "validations" do
    it { should validate_presence_of(:content) }
  end
end
