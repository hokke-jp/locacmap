require 'rails_helper'

describe 'AccountActivations', type: :request do
  before do
    ActionMailer::Base.deliveries.clear
  end

  context 'アカウント作成フォーム入力後' do
    before do
      post signup_path, params: { user: { name: 'Example User',
                                          email: 'user@example.com',
                                          password: 'password',
                                          password_confirmation: 'password' } }
      @user = assigns(:user)
    end

    it 'メールが送られ、有効化はされていない' do
      expect(ActionMailer::Base.deliveries.size).to eq 1
      expect(@user.activated?).to be false
    end

    it 'メールアドレスは正しいが有効化トークンが不正な場合は、ログインできない' do
      get edit_account_activation_path('invalid token', email: @user.email)
      expect(response).to redirect_to root_url
    end

    it '有効化トークンは正しいがメールアドレスが無効な場合は、ログインできない' do
      get edit_account_activation_path(@user.activation_token, email: 'wrong')
      expect(response).to redirect_to root_url
    end

    it 'メールアドレスと有効化トークンが正しい場合、ログインでき有効化できている' do
      get edit_account_activation_path(@user.activation_token, email: @user.email)
      expect(response).to redirect_to user_path(@user)
      expect(@user.reload.activated?).to be true
    end
  end
end
