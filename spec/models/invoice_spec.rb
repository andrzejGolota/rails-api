require 'spec_helper'

describe Invoice do

  describe "validations" do
    it { is_expected.to validate_presence_of :user_id }
    it { is_expected.to validate_presence_of :client_id }
    it { is_expected.to validate_presence_of :invoice_number }
    it { is_expected.to validate_presence_of :subject }
    it { is_expected.to validate_presence_of :company_id }
    it { is_expected.to validate_presence_of :state }
  end

  context "state machine validations" do

  end

  describe "db columns" do
    it { should have_db_column :id }
    it { should have_db_column :user_id }
    it { should have_db_column :client_id }
    it { should have_db_column :invoice_number }
    it { should have_db_column :subject }
    it { should have_db_column :company_id }
    it { should have_db_column :state }
    it { should have_db_column :comment }
  end

  describe "methods" do

    context "total invoice price" do

    end

    context "state humanizer" do

    end

  end

  describe "state machine" do

    context "should have correct initial state" do

    end

    context "has correct transitions" do
    end

    context "can be accepted by client" do
    end

  end

  describe "assiociations" do
    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to :client }
    it { is_expected.to belong_to :company }
    it { is_expected.to have_many :costs }
  end

  describe "nested attributes" do
    it { should accept_nested_attributes_for :costs }
  end

end
