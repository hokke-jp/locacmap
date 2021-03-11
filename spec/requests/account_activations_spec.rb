require 'rails_helper'

describe AccountActivationsController, type: :request do
  context 'アカウント作成フォーム入力後' do
    before do
      ActionMailer::Base.deliveries.clear
      alice = build(:user)
      post signup_path, params: { user: { name: alice.name,
                                          email: alice.email,
                                          password: 'foobar',
                                          password_confirmation: 'foobar' } }
      @user = assigns(:user)
    end

    it 'アカウントはまだ有効化されていない' do
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

    context 'メールアドレスと有効化トークンが正しい場合' do
      before do
        get edit_account_activation_path(@user.activation_token, email: @user.email)
      end

      it 'ログインできる' do
        expect(response).to redirect_to user_path(@user)
      end

      it 'ユーザーは有効化されている' do
        expect(@user.reload.activated?).to be true
      end
    end
  end
end
