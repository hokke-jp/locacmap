require 'rails_helper'

describe PasswordResetsController, type: :system do
  let!(:user) { create(:user) }

  describe '#new' do
    it '非ログイン時、"password_resets#new"に遷移できる' do
      visit login_path
      click_on 'パスワードをお忘れの方'
      expect(page).to have_title('パスワードを忘れた | 歴史地図')
      expect(page).to have_content('パスワードを忘れた')
    end
  end

  describe '#create' do
    before do
      visit new_password_reset_path
    end

    it '無効な入力では警告が出る' do
      fill_in 'メールアドレス',	with: ''
      click_on '送信'
      expect(page).to have_content('メールアドレスは見つかりませんでした')
      expect(page).to have_title('パスワードを忘れた | 歴史地図')
    end

    it '有効な入力ではメールが送られる' do
      ActionMailer::Base.deliveries.clear
      fill_in 'メールアドレス',	with: user.email
      click_on '送信'
      expect(ActionMailer::Base.deliveries.size).to eq 1
      expect(page).to have_content('パスワード再発行用のメールを送信しました')
      expect(page).to have_title('歴史地図')
    end
  end
end
