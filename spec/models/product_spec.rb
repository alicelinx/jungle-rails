require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it "should save successfully when all fields are filled" do
      product = Product.new(
        name: 'Example Product',
        price: 123,
        quantity: 10,
        category: Category.new(name: 'Example Category')
      )
      expect(product.save).to be true
    end

    it "should not save if name is nil" do
      product = Product.new(
        price: 123,
        quantity: 10,
        category: Category.new(name: 'Example Category')
      )
      expect(product.save).to be false
      expect(product.errors.full_messages).to include("Name can't be blank")
    end

    it "should not save if price is NaN" do
      product = Product.new(
        name: 'Example Product',
        quantity: 10,
        category: Category.new(name: 'Example Category')
      )
      expect(product.save).to be false
      expect(product.errors.full_messages).to include("Price is not a number")
    end

    it "should not save if quantity is nil" do
      product = Product.new(
        name: 'Example Product',
        price: 123,
        category: Category.new(name: 'Example Category')
      )
      expect(product.save).to be false
      expect(product.errors.full_messages).to include("Quantity can't be blank")
    end

    it "should not save if category is nil" do
      product = Product.new(
        name: 'Example Product',
        price: 123,
        quantity: 10
      )
      expect(product.save).to be false
      expect(product.errors.full_messages).to include(
        "Category must exist", 
        "Category can't be blank"
      )
    end

  end
end
