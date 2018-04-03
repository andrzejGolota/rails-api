require 'rails_helper'

RSpec.describe OrderProduct, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of :order_id }
    it { is_expected.to validate_presence_of :product_id }
  end

  describe "db columns" do
    it { should have_db_column :id }
    it { should have_db_column :order_id  }
    it { should have_db_column :product_id }
  end

  describe "assiociations" do
    it { is_expected.to belong_to :product }
    it { is_expected.to belong_to :order }
  end
end
