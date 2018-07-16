require 'rails_helper'

RSpec.describe Order, type: :model do

  describe "validations" do
    it { is_expected.to validate_presence_of :state }
    it { is_expected.to validate_presence_of :user_id }
  end

  describe "aasm" do

    context "default state" do
      before do
        @order = create(:order)
      end
      subject { @order }
      it {
        should have_state(:new).on(:state)
        should transition_from(:new).to(:failed).on_event(:failure).on(:state)
      }
    end

    context "can't be finalized without valid payment" do
      before do
        @order = create(:order_with_payment)
      end
      subject { @order }
      it {
        should_not allow_event(:finalize).on(:state)
        should_not allow_transition_to(:completed).on(:state)
      }
    end

    context "completed payment can finalize order" do
      before do
        @order = create(:order_with_completed_payment)
      end
      subject { @order }
      it {
        should transition_from(:new).to(:completed).on_event(:finalize).on(:state)
      }
    end

    it "emails after create" do
      user = create(:basic_user)
      create(:order)
      validate_basic_email_sending(user: user)
    end

    it "emails after order is finalized" do
      user = create(:basic_user)
      order = create(:order_with_completed_payment, user: user)
      validate_basic_email_sending(user: user, subject: "Your order #{order.id} is finalized!")
    end

    it "emails after order failure" do
      user = create(:basic_user)
      order = create(:order, user: user)
      validate_basic_email_sending(user: user, subject: "Your order #{order.id} is canceled.")
    end

  end

  describe "db columns" do
    it { should have_db_column :id }
    it { should have_db_column :user_id }
    it { should have_db_column :state }
  end

  describe "assiociations" do
    it { is_expected.to belong_to :user }
    it { is_expected.to have_many :payments }
    it { is_expected.to have_many(:products).through(:order_products) }
  end
end
