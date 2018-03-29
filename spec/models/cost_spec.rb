require 'spec_helper'

describe Cost do

  describe "validations" do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :unit }
    it { is_expected.to validate_presence_of :quantity }
    it { is_expected.to validate_presence_of :unit_price }
    it { is_expected.to validate_presence_of :tax }
    it { is_expected.to validate_presence_of :user_id }
    it { is_expected.to validate_presence_of :invoice_id }
  end

  describe "db columns" do
    it { should have_db_column :id }
    it { should have_db_column :name }
    it { should have_db_column :unit }
    it { should have_db_column :quantity }
    it { should have_db_column :unit_price }
    it { should have_db_column :tax }
    it { should have_db_column :cost_type }
    it { should have_db_column :user_id }
    it { should have_db_column :invoice_id }
  end

  describe "methods" do

    context "total price" do

    end

    context "automatical tax calculation" do

    end

  end

  describe "assiociations" do
    it { is_expected.to belong_to :invoice }
    it { is_expected.to belong_to :user }
  end


end
