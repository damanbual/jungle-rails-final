require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    let(:category) { Category.create(name: "Sample Category") } # Create a category directly

    it 'is valid with all fields set' do
      product = Product.new(
        name: "Sample Product",
        price: 19.99,
        quantity: 10,
        category: category
      )
      expect(product).to be_valid
    end

    it 'is invalid without a name' do
      product = Product.new(
        name: nil, # Set name to nil to test validation
        price: 19.99,
        quantity: 10,
        category: category
      )
      product.valid? # Validate to populate errors
      expect(product.errors.full_messages).to include("Name can't be blank")
    end

    it 'is invalid without a price' do
      product = Product.new(
        name: "Sample Product",
        price_cents: nil, # Set price_cents to nil to test validation
        quantity: 10,
        category: category
      )
      product.valid? # Validate to populate errors
      expect(product.errors.full_messages).to include("Price can't be blank")
    end

    it 'is invalid without a quantity' do
      product = Product.new(
        name: "Sample Product",
        price: 19.99,
        quantity: nil, # Set quantity to nil to test validation
        category: category
      )
      product.valid? # Validate to populate errors
      expect(product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'is invalid without a category' do
      product = Product.new(
        name: "Sample Product",
        price: 19.99,
        quantity: 10,
        category: nil # Set category to nil to test validation
      )
      product.valid? # Validate to populate errors
      expect(product.errors.full_messages).to include("Category can't be blank")
    end
  end
end