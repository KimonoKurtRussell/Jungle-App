require 'rails_helper'

=begin
Make sure these validations are in the original model with validations
=end

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_presence_of(:quantity) }
    it { is_expected.to validate_presence_of(:category) }
    it { is_expected.to validate_presence_of(:description) }

    @category = Category.find_or_create_by! name: "Functional clothing"

    product_test = @category.products.create!({
      name: "Javashirt",
      description: "made of javascript",
      quantity: 1,
      price: 41.99,
    })


    it "It's name is" do
      expect(product_test.name).to eql "Javashirt"
    end

    it "It's description is" do
      # product_test.description = "made of javascript"
      expect(product_test.description).to eql "made of javascript"
    end

    it "It's quantity is" do
      expect(product_test.quantity).to eql 1
    end

    it "It's price is" do
      expect(product_test.price).to eql 41.99
    end

    it "It's category is" do
      expect(product_test.category.name).to eql "Functional clothing"
    end




  end
end

