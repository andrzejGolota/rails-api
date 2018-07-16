require 'spec_helper'

describe Attachment do
  describe "validations" do
    it { is_expected.to validate_presence_of :file }
    it { is_expected.to validate_presence_of :invoice_id }
    it { is_expected.to validate_presence_of :user_id }
    context "file validations" do
      before do
        @attachment = create(:too_big_attachment)
        @attachment2 = create(:bad_extension_attachment)
      end
      subject { @attachment }
      it { should_not be_valid }
      subject { @attachment2 }
      it { should_not be_valid }
    end
  end

  describe "db columns" do
    it { should have_db_column :id }
    it { should have_db_column :invoice_id }
    it { should have_db_column :user_id }
  end

  describe "assiociations" do
    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to :invoice }
  end
end
