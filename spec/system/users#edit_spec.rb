require 'rails_helper'

describe 'Users', type: :system do
  describe '#edit' do
    let!(:user) { create(:user) }
    let!(:other_user) { create(:user) }

    it 'ログイン時、"users#edit"に遷移できる' do
      log_in_as(user)
      click_on user.name
      click_on 'アカウント編集'
      expect(page).to have_title('アカウント編集 | 歴史地図')
      expect(page).to have_content('アカウント編集')
    end

    it '非ログイン時、"users#edit"に遷移できない' do
      visit edit_user_path(user)
      expect(page).not_to have_title('アカウント編集 | 歴史地図')
      expect(page).to have_title('ログイン | 歴史地図')
      expect(page).to have_content('ログインしてください')
    end

    it 'ログイン時でも、他のユーザーの"users#edit"には遷移できない' do
      log_in_as(user)
      visit edit_user_path(other_user)
      expect(page).to have_title('歴史地図')
    end

    it 'フレンドリーフォワーディングテスト' do
      visit edit_user_path(user)
      fill_in 'メールアドレス',	with: user.email
      fill_in 'パスワード',	with: user.password
      click_button 'ログイン'
      expect(page).to have_title('アカウント編集 | 歴史地図')
      expect(page).to have_content('アカウント編集')
    end
  end
end