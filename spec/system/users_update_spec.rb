require 'rails_helper'

describe UsersController, type: :system do
  describe '#update' do
    let!(:user) { create(:user) }

    it '無効な入力では、alertが出る' do
      log_in_as(user)
      visit edit_user_path(user)
      fill_in 'ユーザー名',	with: ''
      fill_in 'メールアドレス',	with: ''
      fill_in 'パスワード',	with: 'foo'
      fill_in 'パスワード（確認）',	with: 'foobar'
      click_on '更新'
      expect(page).to have_content('5つの入力エラー')
    end

    it '無効な入力後、"users#edit"が表示される' do
      log_in_as(user)
      visit edit_user_path(user)
      fill_in 'ユーザー名',	with: ''
      fill_in 'メールアドレス',	with: ''
      fill_in 'パスワード',	with: 'foo'
      fill_in 'パスワード（確認）',	with: 'foobar'
      click_on '更新'
      expect(page).to have_title('アカウント編集 | 歴史地図')
      visit current_path
      expect(page).to have_title('アカウント編集 | 歴史地図')
    end

    it '有効な入力では、updateが行われている' do
      log_in_as(user)
      visit edit_user_path(user)
      fill_in 'ユーザー名',	with: 'Alice'
      fill_in 'メールアドレス',	with: 'Alice@example.com'
      click_on '更新'
      expect(User.find_by(email: 'alice@example.com').name).to eq 'Alice'
    end

    it '有効な入力後、"users#show"に遷移し、alertが出る' do
      log_in_as(user)
      visit edit_user_path(user)
      fill_in 'ユーザー名',	with: 'Bob'
      fill_in 'メールアドレス',	with: 'bob@example.com'
      fill_in 'パスワード',	with: 'bobbob'
      fill_in 'パスワード（確認）',	with: 'bobbob'
      click_on '更新'
      expect(page).to have_title('Bob | 歴史地図')
      expect(page).to have_content('更新しました')
    end
  end
end
