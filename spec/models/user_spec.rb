require 'rails_helper'

RSpec.describe User, type: :model do
  let(:my_user) { create(:user) }
  it { is_expected.to have_many(:wikis) }

  describe "attributes" do
    it "responds to admin?" do
      expect(my_user).to respond_to(:admin?)
    end

    it "responds to standard?" do
      expect(my_user).to respond_to(:standard?)
    end
  end

  describe "roles" do
    it "is standand by default" do
      expect(my_user.role).to eql("standard")
    end

    context "standard user" do
      it "returns true for #standard?" do
        expect(my_user.standard?).to be_truthy
      end

      it "returns false for #admind?" do
        expect(my_user.admin?).to be_falsey
      end
    end

    context "admin user" do
      before do
        user.admin!
      end

      it "returns false for #standard?" do
        expect(my_user.standard?).to be_falsey
      end

      it "returns true for #admin?" do
        expect(my_user.admin?).to be_truthy
      end
    end
  end
end
