require 'spec_helper'

describe Company do
  describe "validations" do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :company_number }
    it { is_expected.to validate_presence_of :vat_number }
    it { is_expected.to validate_presence_of :street }
    it { is_expected.to validate_presence_of :postcode }
    it { is_expected.to validate_presence_of :city }
    it { is_expected.to validate_presence_of :country_code }
    it { is_expected.to validate_presence_of :user_id }
    context "company data uniqueness" do
      before do
        @company = create(:company)
      end
      subject { @company }
      it {
        should validate_uniqueness_of(:company_number)
        should validate_uniqueness_of(:vat_number)
      }
    end
  end

  describe "db columns" do
    it { should have_db_column :id }
    it { should have_db_column :name }
    it { should have_db_column :company_number }
    it { should have_db_column :vat_number }
    it { should have_db_column :street }
    it { should have_db_column :postcode }
    it { should have_db_column :city }
    it { should have_db_column :country_code }
    it { should have_db_column :user_id }
  end

  describe "assiociations" do
    it { is_expected.to belong_to :user }
    it { is_expected.to have_many :received_invoices }
    it { is_expected.to have_many :issued_invoices }
    it { is_expected.to belong_to :country }
  end

end
