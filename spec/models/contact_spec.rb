require 'spec_helper'

describe Contact do

  describe "validations" do
    it { is_expected.to validate_presence_of :user_id }
    it { is_expected.to validate_presence_of :first_name }
    it { is_expected.to validate_presence_of :last_name }

    context "accepted is required only if we merge contact with user" do
      before do
        @contact = create(:contact)
      end
      subject { @contact }
      it {
        should validate_inclusion_of(:accepted).in_array([true, false])
      }
    end

    context "only premium users can create contacts" do
      before do
        @contact = create(:contact, user: create(:basic_user))
      end
      subject { @contact }
      it { should_not be_valid }
    end

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

    it "assigns automatically first name and last name" do
      user = create(:basic_user)
      creator = create(:premium_user)
      contact = create(:contact, user: creator, contact_user_id: user.id)
      contact.accepted = true
      contact.save
      expect(contact.first_name).to eq(user.first_name)
      expect(contact.last_name).to eq(user.last_name)
    end

    it "shows contact for user only if it is accepted" do
      user = create(:basic_user)
      creator = create(:premium_user)
      contact = create(:contact, user: creator, contact_user_id: user.id)
      expect(creator.accepted_contacts.length).to eq(0)
      contact.accepted = true
      contact.save
      expect(creator.accepted_contacts.contacts.length).to eq(1)
    end

    it "has default contact address method" do
      contact = create(:contact)
      contact_address = create(:contact_address, contact: contact)
      expect(contact.default_address.id).to eq(contact_address.id)
    end

    it "shows unaccepted contacts" do
      user = create(:basic_user)
      creator = create(:premium_user)
      create(:contact, user: creator, contact_user_id: user.id)
      expect(creator.awaiting_contacts.length).to eq(1)
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
