require 'spec_helper'

describe Contact do

  describe "validations" do
    it { is_expected.to validate_presence_of :user_id }
    it { is_expected.to validate_presence_of :first_name }
    it { is_expected.to validate_presence_of :last_name }

    context "accepted is required only if we merge contact with user" do
      before do
        @contact = Factory.new(:contact)
      end
      subject { @contact }
      it {
        should validate_presence_of :accepted #to be in correct state, we will test it in aasm section
      }
    end
  end

  context "state machine validations" do

  end

  describe "db columns" do
    it { should have_db_column :id }
    it { should have_db_column :user_id }
    it { should have_db_column :contact_user_id }
    it { should have_db_column :first_name }
    it { should have_db_column :last_name }
    it { should have_db_column :company_id }
    it { should have_db_column :accepted }
  end

  describe "methods" do

    context "shows contact for user only if it is accepted" do

    end

    context "only user asked for being added is able to accept / refuse" do

    end

  end

  describe "assiociations" do
    it { is_expected.to belong_to :user }
    it { is_expected.to have_many :contact_address }
  end

  describe "nested attributes" do
    it { should accept_nested_attributes_for :contact_address }
  end

end
