require 'spec_helper'

RSpec.describe Product, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :active }
    it { is_expected.to validate_presence_of :price }
  end

  describe "db columns" do
    it { should have_db_column :id }
    it { should have_db_column :name }
    it { should have_db_column :active }
    it { should have_db_column :price }
  end

  describe "methods" do
    it "default active scope" do
      product = create(:product, active: false)
      validate_default_scope('product', product)
    end
  end

  describe "assiociations" do
    it { is_expected.to have_many(:orders).through(:order_products) }
  end
end
