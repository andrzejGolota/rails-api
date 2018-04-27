require 'spec_helper'

describe Message do

  describe "validations" do
    it { is_expected.to validate_presence_of :user_id }
    it { is_expected.to validate_presence_of :recipent_id }
    it { is_expected.to validate_presence_of :content }
    it { is_expected.to validate_presence_of :state }

    context "valid attachment" do
      before do
        @message = build(:message, attachment: Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'large_avatar.jpg'), 'image/png'))
      end
      subject { @message }
      it { should_not be_valid }
    end

  end

  context "aasm" do
    it "has sent status by default" do
      message = create(:message)
      expect(message).to have_state :sent
      expect(message).to transition_from(:sent).to(:received).on_event(:read)
    end
    context "reading the newest message sets other to received too" do
      before do
        @user = create(premium_user)
        create_list(:sent_message, 5, user: @user)
        create(:received_message, user: @user)
      end
      subject { @user.messages.where(state: 'sent').length }
      it { should be_eq(0) }
    end
    context "needs received_at if read" do
      before do
        @message = build(:received_message, received_at: nil)
      end
      subject { @message }
      it { should_not be_valid }
    end
  end

  describe "db columns" do
    it { should have_db_column :id }
    it { should have_db_column :user_id }
    it { should have_db_column :recipent_id }
    it { should have_db_column :content }
    it { should have_db_column :state }
  end

  describe "methods" do
    let(:conversation_messages) {
      Message.where(user_id: @user.id, recipent_id: @recipent.id)
             .or(Message.where(user_id: @recipent.id, recipent_id: @user.id))
             .order(created_at: :asc)
    }
    context "gets conversation with user" do
      before do
        @user = create(:premium_user)
        @recipent = create(:premium_user)
        create_list(:message, 10, user: @user, recipent: @recipent)
        create_list(:message, 10, user: @recpient, recipent: @user)
      end
      subject { @user.conversation_with(recipent) }
      it "compare method" do
        expect(subject.length).to eq(20)
        expect(subject).to match_array(conversation_messages)
      end
    end
  end

  describe "assiociations" do
    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to :recipent }
  end
end
