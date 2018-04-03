require 'rails_helper'

describe ContactAddress do

  describe "validations" do
    it { is_expected.to validate_presence_of :phone_number }
    it { is_expected.to validate_presence_of :street }
    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_presence_of :postcode }
    it { is_expected.to validate_presence_of :city }
    it { is_expected.to validate_presence_of :default }
    context "first address must be default" do
      before do
        @contact_address = create(:contact_address, default: false)
      end
      subject{ @contact_address }
      it {
        is_expected.not_to be_valid
      }
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
    it "automatically changes default address if new is added" do
      3.times do
        contact = create(:contact)
        create(:contact_address, default: true, contact: contact)
      end
      expect(contact.contact_addresses.where(default: true).length).to eq(1)
    end
  end

  describe "assiociations" do
    it { is_expected.to belong_to :contact }
  end

end
