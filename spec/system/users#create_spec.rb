require 'rails_helper'

describe 'Users', type: :system do
  describe '#create' do
    let!(:user) { build(:user) }

    it '無効な入力では、ユーザー数は増えない' do
      visit signup_path
      fill_in 'ユーザー名',	with: 'A' * 21
      # クライアント側検証が発生し登録ボタンが押せなくなるためmailは有効なものを使用
      fill_in 'メールアドレス',	with: user.email
      fill_in 'パスワード',	with: 'foo'
      fill_in 'パスワード（確認）',	with: 'foobar'
      expect { click_on '登録' }.not_to change(User, :count)
      expect(page).to have_content('3つの入力エラー')
    end

    it '無効な入力後再読み込みすると、alertが消える' do
      visit signup_path
      fill_in 'ユーザー名',	with: 'A' * 21
      fill_in 'メールアドレス',	with: user.email
      fill_in 'パスワード',	with: 'foo'
      fill_in 'パスワード（確認）',	with: 'foobar'
      click_on '登録'
      expect(page).to have_title('アカウント作成 | 歴史地図')
      expect(page).to have_content('3つの入力エラー')
      visit current_path
      expect(page).to have_title('アカウント作成 | 歴史地図')
      expect(page).not_to have_content('3つの入力エラー')
    end

    it '有効な入力では、ユーザー数が増える' do
      visit signup_path
      fill_in 'ユーザー名',	with: user.name
      fill_in 'メールアドレス',	with: user.email
      fill_in 'パスワード',	with: user.password
      fill_in 'パスワード（確認）',	with: user.password
      expect { click_on '登録' }.to change { User.count }.by(1)
      expect(page).to have_content('確認メールを送信しました')
    end

    it '有効な入力後再読み込みすると、alertが消える' do
      visit signup_path
      fill_in 'ユーザー名',	with: user.name
      fill_in 'メールアドレス',	with: user.email
      fill_in 'パスワード',	with: user.password
      fill_in 'パスワード（確認）',	with: user.password
      click_on '登録'
      expect(page).to have_title('歴史地図')
      expect(page).to have_content('確認メールを送信しました')
      visit current_path
      expect(page).to have_title('歴史地図')
      expect(page).not_to have_content('確認メールを送信しました')
    end
  end
end