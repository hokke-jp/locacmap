require 'rails_helper'

describe PasswordResetsController, type: :request do
  let!(:user) { create(:user) }
  before do
    ActionMailer::Base.deliveries.clear
  end

  it '無効なメールアドレスの場合、再発行メールは送られない' do
    post password_resets_path, params: { password_reset: { email: '' } }
    expect(ActionMailer::Base.deliveries.size).to eq 0
    expect(response).to render_template('password_resets/new')
  end

  it '有効なメールアドレスの場合、再発行メールが送られる' do
    post password_resets_path, params: { password_reset: { email: user.email } }
    expect(ActionMailer::Base.deliveries.size).to eq 1
    expect(response).to redirect_to root_url
  end

  context '有効なメールアドレスに再発行メールを送信した場合' do
    before do
      post password_resets_path, params: { password_reset: { email: user.email } }
      @user = assigns(:user)
    end

    it 'クエリパラメータのメールアドレスが無効な場合、再発行ページに遷移できない' do
      get edit_password_reset_path(@user.reset_token, email: '')
      expect(response).to redirect_to root_url
    end

    it 'クエリパラメータのトークンが無効な場合、再発行ページに遷移できない' do
      get edit_password_reset_path('wrong token', email: @user.email)
      expect(response).to redirect_to root_url
    end

    it 'ユーザーが有効でない場合、再発行ページに遷移できない' do
      @user.toggle!(:activated)
      get edit_password_reset_path(@user.reset_token, email: @user.email)
      expect(response).to redirect_to root_url
    end

    it 'トークンの有効期限が切れている場合、再発行ページに遷移できない' do
      @user.update_attribute(:reset_sent_at, 3.hours.ago)
      get edit_password_reset_path(@user.reset_token, email: @user.email)
      expect(response).to redirect_to new_password_reset_url
    end

    it '有効なクエリパラメータの場合、再発行ページに遷移できる' do
      get edit_password_reset_path(@user.reset_token, email: @user.email)
      expect(response).to render_template('password_resets/edit')
      expect(Capybara.string(response.body)).to be_has_css '[name=email]', visible: false
    end

    context '再発行ページに遷移した場合' do
      # before do
      #   get edit_password_reset_path(@user.reset_token, email: @user.email)
      # end

      it 'パスワードとパスワード（確認）が異なる場合、変更できない' do
        patch password_reset_path(@user.reset_token),
              params: { email: @user.email,
                        user: { password: 'wrongpass',
                                password_confirmation: 'passwrong' } }
        expect(response).to render_template('password_resets/edit')
      end

      it 'パスワードが空の場合、変更できない' do
        patch password_reset_path(@user.reset_token),
              params: { email: @user.email,
                        user: { password: '',
                                password_confirmation: '' } }
        expect(response).to render_template('password_resets/edit')
      end

      it '有効なパスワードとパスワード（確認）の場合、変更できる' do
        patch password_reset_path(@user.reset_token),
              params: { email: @user.email,
                        user: { password: 'newpass',
                                password_confirmation: 'newpass' } }
        expect(response).to redirect_to @user
      end

      it '有効なパスワードとパスワード（確認）の場合、reset_digestがnilになる' do
        patch password_reset_path(@user.reset_token),
              params: { email: @user.email,
                        user: { password: 'newpass',
                                password_confirmation: 'newpass' } }
        expect(@user.reload.reset_digest).to eq nil
      end
    end
  end
end
