require 'rails_helper'

RSpec.describe Wiki, type: :model do
  let(:wiki) {Wiki.create!(title: "My first wiki", body: " This is some cool text to add to my wiki", private: false)}

  describe "attributes" do

      it "should respond to title" do
        expect(wiki).to respond_to(:title)
      end

      it "should repsond to body" do
        expect(wiki).to respond_to(:body)
      end

      it "should repsond to private" do
        expect(wiki).to respond_to(:private)
      end

  end


end
