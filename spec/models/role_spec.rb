require 'spec_helper'

describe Role do

  describe "validations" do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_inclusion_of(:active).in_array([true, false]) }

    context "unique role name" do
      before do
        @role = create(:role)
      end
      subject { @role }
      it { should validate_uniqueness_of(:name) }
    end

  end

  describe "db columns" do
    it { should have_db_column :id }
    it { should have_db_column :name }
    it { should have_db_column :active }
  end

  describe "methods" do
    it "default active scope" do
      role = create(:inactive_role)
      validate_default_scope('role', role)
    end
  end

  describe "assiociations" do
    it { is_expected.to have_many :users }
  end

end
