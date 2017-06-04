require 'rails_helper'

RSpec.describe Wiki, type: :model do
  let(:wiki) { Wiki.create!(title: "New Wiki Title", body: "New Wiki Body", private: false) }

  describe "attributes" do
    it "responds to title" do
      expect(my_wiki).to respond_to(:title)
    end

    it "responds to body" do
      expect(my_wiki).to respond_to(:body)
    end

    it "responds to private" do
      expect(my_wiki).to respond_to(:private)
    end
  end
end
