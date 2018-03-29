require 'spec_helper'

describe User do
  describe "validations" do
    it { is_expected.to validate_presence_of :first_name }
    it { is_expected.to validate_presence_of :last_name }
    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_presence_of :login }
    it { is_expected.to validate_presence_of :password_digest }
    it { is_expected.to validate_presence_of :is_active }
    it { is_expected.to validate_presence_of :activation_sent_date }
    it { is_expected.to validate_presence_of :contact_visibility }
    it { is_expected.to validate_presence_of :role_id }
    context "unique email and login" do
      before do
        @user = create(:basic_user)
      end
      subject { @user }
      it { should validate_uniqueness_of(:email) }
      it { should validate_uniqueness_of(:login) }
    end
    describe "checks email and login regex" do
      it "correct regex format" do
        user = create(:basic_user)
        email_regex = User::EMAIL_REGEX
        login_regex = User::LOGIN_REGEX
        expect(user.email).to match(email_regex)
        expect(user.login).to match(login_regex)
        expect('invalid.email@test').not_to match(email_regex)
        expect('1invalid.login-').not_to match(login_regex)
      end
      it "model check for email" do
        user_two = create(:basic_user)
        user_two.email = 'invalid@email'
        expect(user_two).not_to be_valid
      end
      it "model check for login" do
        user_three = create(:basic_user)
        user_three.login = '1invalidlogin.'
        expect(user_three).not_to be_valid
      end
    end
    context "downcasing email and login" do
      before do
        @user = create(:basic_user, email: "Uppercase@test.com", login: "Uppercase69")
      end
      subject { @user }
      it { is_expected.to have_attributes(email: @user.email.downcase, login: @user.login.downcase) }
    end
    context "attributes length" do
      before do
        @user = build(:basic_user)
      end
      subject { @user }
      it { should validate_length_of(:password_digest).is_at_least(8) }
      it { should validate_length_of(:login).is_at_least(3).is_at_most(20) }
      it { should validate_length_of(:email).is_at_least(6).is_at_most(30) }
    end

  end

  describe "db columns" do
    it { should have_db_column :id }
    it { should have_db_column :uid }
    it { should have_db_column :first_name }
    it { should have_db_column :last_name }
    it { should have_db_column :email }
    it { should have_db_column :login }
    it { should have_db_column :password_digest }
    it { should have_db_column :is_active }
    it { should have_db_column :activation_sent_date }
    it { should have_db_column :activated_at }
    it { should have_db_column :activation_digest }
    it { should have_db_column :remember_digest }
    it { should have_db_column :reset_digest }
    it { should have_db_column :reset_sent_date }
    it { should have_db_column :provider }
    it { should have_db_column :avatar }
    it { should have_db_column :contact_visibility }
    it { should have_db_column :role_id }
  end

  describe "methods" do

    context "user types" do
      it { validate_role_method('basic_user') }
      it { validate_role_method('premium_user') }
      it { validate_role_method('mod_user') }
      it { validate_role_method('admin_user') }
    end
    it "product scope" do
      user = create(:basic_user)
      order = create(:order, user_id: user.id)
      product = create(:product)
      create(:order_products, order_id: order.id, product_id: product.id)
      expect(user.products.length).to eq(1)
    end
    it "remembers and forgets" do
      user = create(:basic_user)
      user.remember
      expect(user.remember_digest).not_to be_nil
      user.forget
      expect(user.remember_digest).to be_nil
    end
    context "password reseting" do
      user = create(:basic_user)
      user.reset_password
      it "sends email after reseting user" do
        validate_basic_email_sending(user: user)
      end
      it "creates diggest correctly" do
        expect(user.reset_digest).not_to be_nil
        expect(user.reset_sent_date).not_to be_nil
      end
    end
    context "user activation" do
      user = create(:basic_user)
      it "sends email after user is created" do
        validate_basic_email_sending(user: user)
      end
      it "creates digest correctly" do
        user.activate
        expect(user.is_active).to be_true
      end
    end

  end

  describe "assiociations" do
    it { is_expected.to belong_to :role }
    it { is_expected.to have_many :invoices }
    it { is_expected.to have_many :orders }
    it { is_expected.to have_many :payments, through: :orders}
    it { is_expected.to have_many :companies }
    it { is_expected.to have_many :costs, through: :invoices }
    it { is_expected.to have_many :sent_messages }
    it { is_expected.to have_many :received_messages }
    it { is_expected.to have_many :contacts }
  end
end
