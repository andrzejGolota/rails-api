require 'spec_helper'

describe Country do
  describe "validations" do
    it { is_expected.to validate_presence_of :country_name }
    it { is_expected.to validate_presence_of :iso_code }
    it { is_expected.to validate_inclusion_of(:active).in_array([true, false]) }

    context "unique country codes" do
      before do
        @country = create(:country)
      end
      subject { @country }
      it {
        should validate_uniqueness_of(:country_name)
        should validate_uniqueness_of(:iso_code)
      }
    end

  end

  describe "db columns" do
    it { should have_db_column :id }
    it { should have_db_column :country_name }
    it { should have_db_column :iso_code }
    it { should have_db_column :active }
  end

  describe "methods" do
    it "default active scope" do
      country = create(:country, active: false)
      validate_default_scope('country', country)
    end
  end

  describe "assiociations" do
    it { is_expected.to have_many :companies }
  end

end
