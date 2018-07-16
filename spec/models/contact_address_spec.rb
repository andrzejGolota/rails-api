require 'rails_helper'

describe ContactAddress do

  describe "validations" do
    it { is_expected.to validate_presence_of :phone_number }
    it { is_expected.to validate_presence_of :contact_id }
    it "first address must be default" do
      expect(create(:contact_address).default).to be_truthy
    end
  end

  describe "db columns" do
    it { should have_db_column :id }
    it { should have_db_column :contact_id }
    it { should have_db_column :phone_number }
    it { should have_db_column :street }
    it { should have_db_column :email }
    it { should have_db_column :postcode }
    it { should have_db_column :city }
    it { should have_db_column :default }
  end

  describe "methods" do
    it "only one address can be default" do
      contact = create(:contact)
      3.times do
        create(:contact_address, default: true, contact_id: contact.id)
      end
      expect(contact.contact_addresses.where(default: true).length).to eq(1)
    end
  end

  describe "assiociations" do
    it { is_expected.to belong_to :contact }
  end

end
