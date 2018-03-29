require 'spec_helper'

describe Message do

  describe "validations" do
    it { is_expected.to validate_presence_of :user_id }
    it { is_expected.to validate_presence_of :recipent_id }
    it { is_expected.to validate_presence_of :content }
    it { is_expected.to validate_presence_of :state }
  end

  context "state machine validations" do

  end

  describe "db columns" do
    it { should have_db_column :id }
    it { should have_db_column :user_id }
    it { should have_db_column :recipent_id }
    it { should have_db_column :content }
    it { should have_db_column :state }
  end

  describe "methods" do

    context "gets messages collection for conversation" do

    end

  end

  describe "state machine test" do

    context "message is sent" do
    end

    context "message is read after receiving" do
    end

  end

  describe "assiociations" do
    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to :recipent }
  end
end
