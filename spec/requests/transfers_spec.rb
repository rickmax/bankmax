 require 'rails_helper'
 require_relative '../support/controller_macros'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/transfers", type: :request do

  before(:all) do
    @user1 = create(:user)
    @user2 = create(:user)
    @account1 = create(:account, user: @user1)
    @account2 = create(:account, user: @user2)
  end
  # Bank. As you add validations to Bank, be sure to
  # adjust the attributes here as well.

  let(:valid_session) { {} }

  let(:valid_session) { {"warden.user.user.key" => session["warden.user.user.key"]} }

  let(:valid_attributes) {
    {amount: 100.00, account: @user1.account, account_to: @user2.account.id}
  }

  let(:invalid_attributes) {
    {amount: nil, account: nil, account_to: nil}
  }

  describe "GET /index" do
    it "renders a successful response" do
      Deposit.create!(account: @account1, amount: 100.00)
      Transfer.create! valid_attributes
      sign_in @user1
      get deposits_url
      expect(response).to have_http_status(200)
    end

    it "include transfers response" do
      Deposit.create!(account: @account1, amount: 100.00)
      transfer = Transfer.create! valid_attributes
      sign_in @user1
      get transfers_url
      expect(transfer).to have_attributes(:amount => 100.00)
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      Deposit.create!(account: @account1, amount: 100.00)
      transfer = Transfer.create! valid_attributes
      sign_in @user1
      get transfer_url(transfer)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      sign_in @user1
      get new_transfer_url(@transfer)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new transfer" do
        Deposit.create!(account: @account1, amount: 100.00)
        sign_in @user1
        post transfers_url, params: { transfer: {account: @account1.id, amount: 50.00, account_to: @account2.id } }
        expect(Transfer.last).to have_attributes(:amount => 50.00)
      end
    end
  end
end