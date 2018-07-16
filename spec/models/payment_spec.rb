require 'spec_helper'

describe Payment do
  describe "validations" do
    it { is_expected.to validate_presence_of :state }
    it { is_expected.to validate_presence_of :user_id }
    it { is_expected.to validate_presence_of :order_id }
    it { is_expected.to validate_presence_of :amount }

    context "new payment after finalizing one" do
      before do
        @completed_payment = create(:completed_payment)
        @payment = build(:payment, order_id: @completed_payment.order_id)
      end
      subject { @payment }
      it {
        should_not be_valid
      }
    end
  end

  describe "methods" do
    it "new payment cancels all pending" do
      order = create(:order)
      3.times do
        create(:payment, order: order)
      end
      expect(Payment.where(state: 'pending').length).to eq(1)
    end
  end

  describe "aasm" do

    describe "correct initial state" do
      before do
        @payment = create(:payment)
      end
      subject { @payment }
      it {
        should transition_from(:pending).to(:failed).on_event(:reject).on(:state)
      }
    end

    describe "correct initial state" do
      before do
        @payment = create(:payment)
      end
      subject { @payment }
      it {
        should_not allow_event(:confirm).on(:state)
        should_not allow_transition_to(:completed).on(:state)
      }  
    end

    context "completed payment state" do
      before do
        @payment = create(:payment, paypal_id: 1)
      end
      subject { @payment }
      it {
        should transition_from(:pending).to(:completed).on_event(:confirm).on(:state)
      }
    end

    it "emails after created new payment" do
      user = create(:basic_user)
      create(:payment, user: user)
      validate_basic_email_sending(user: user)
    end

    it "emails after successful payment" do
      user = create(:basic_user)
      payment = create(:payment, user: user, paypal_id: 1)
      payment.confirm!
      validate_basic_email_sending(user: user, subject: "Your Payment #{payment.id} is confirmed!")
    end

    it "emails after payment failure" do
      user = create(:basic_user)
      payment = create(:payment, user: user)
      payment.reject!
      validate_basic_email_sending(user: user, subject: "Your Payment #{payment.id} was rejected.")
    end

  end

  describe "db columns" do
    it { should have_db_column :id }
    it { should have_db_column :user_id }
    it { should have_db_column :state }
    it { should have_db_column :order_id }
    it { should have_db_column :amount }
    it { should have_db_column :paypal_id }
  end

  describe "assiociations" do
    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to :order }
  end
end
