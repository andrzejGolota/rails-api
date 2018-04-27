require 'spec_helper'

describe Invoice do

  describe "validations" do
    it { is_expected.to validate_presence_of :user_id }
    it { is_expected.to validate_presence_of :client_id }
    it { is_expected.to validate_presence_of :invoice_number }
    it { is_expected.to validate_presence_of :subject }
    it { is_expected.to validate_presence_of :company_id }
    it { is_expected.to validate_presence_of :state }

    context "settled_at is required for final state" do
      before do
        @invoice = create(:settled_invoice)
      end
      subject { @invoice }
      it {
        is_expected.to validate_presence_of :settled_at
      }
    end

    context "settled_at cannot be future date and before creation date" do
      before do
        @future_invoice = create(:settled_invoice, settled_at: Time.now + 2 )
        @too_old_invoice = create(:settled_invoice, created_at: Time.now, settled_at: Time.now - 2)
      end
      subject { @future_invoice }
      it {
        should_not be_valid
      }
      subject { @too_old_invoice }
      it {
        should_not be_valid
      }
    end
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

    it "returns total invoice price" do
      invoice = create(:invoice_with_costs)
      cost_sum = 0
      invoice.costs.each{ |cost| cost_sum = cost_sum + cost.quantity*cost.unit_price }
      expect(invoice.total_value).to eq(cost_sum)
    end

    it "returns total invoice price with taxes" do
      invoice = create(:invoice_with_costs)
      cost_sum = 0
      invoice.costs.each{ |cost| cost_sum = cost_sum + cost.quantity*(cost.unit_price*cost.tax+cost.unit_price) }
      expect(invoice.total_taxed_value).to eq(cost_sum)
    end

  end

  describe "aasm" do

    it "should have correct initial state" do
      invoice = create(:created_invoice)
      expect(invoice).to transition_from(:created).to(:pending).on_event(:fill)
      expect(invoice).to have_state :created
      expect(invoice).to transition_from(:created).to(:draft).on_event(:fill_draft)
      expect(invoice).to_not allow_transition_to :settled
    end

    it "sets the date after settled" do
      invoice = create(:pending_invoice)
      invocie.settle!
      expect(invoice.settled_at).not_to be_nil
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
