require 'rails_helper'

describe 'Users', type: :system do
  describe '#new' do
    it '非ログイン状態なら、"users#new"に遷移できる' do
      visit root_path
      click_on '新規登録'
      expect(page).to have_title('アカウント作成 | 歴史地図')
      expect(page).to have_content 'アカウント作成'
      expect(page).to have_link '登録'
    end
  end

  describe '#create' do
    let!(:user) { build(:user) }
    it '無効な入力では、ユーザー数は増えず、alertが出る' do
      visit signup_path
      fill_in 'ユーザー名',	with: 'A' * 21
      # クライアント側検証が発生し登録ボタンが押せなくなるためmailは有効なものを使用
      fill_in 'メールアドレス',	with: user.email
      fill_in 'パスワード',	with: 'foo'
      fill_in 'パスワード（確認）',	with: 'foobar'
      expect { click_on '登録' }.not_to change(User, :count)
      expect(page).to have_content('3つの入力エラー')
    end

    it '無効な入力後再読み込みすると、"users#new"が表示され、alertが消える' do
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

    it '有効な入力では、ユーザー数が増え、alertが出る' do
      visit signup_path
      fill_in 'ユーザー名',	with: user.name
      fill_in 'メールアドレス',	with: user.email
      fill_in 'パスワード',	with: user.password
      fill_in 'パスワード（確認）',	with: user.password
      expect { click_on '登録' }.to change { User.count }.by(1)
      expect(page).to have_content('確認メールを送信しました')
    end

    it '有効な入力後再読み込みすると、"pages#home"に遷移し、alertが消える' do
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

  describe "#edit" do
    let!(:user) { create(:user) }
    it 'ログイン状態なら、"users#edit"に遷移できる' do
      log_in_as(user)
      click_on user.name
      click_on 'アカウント編集'
      expect(page).to have_title('アカウント編集 | 歴史地図')
      expect(page).to have_content('アカウント編集')
    end

    it '非ログイン状態なら、"users#edit"に遷移できず、ログインを要求される' do
      visit edit_user_path(user)
      expect(page).not_to have_title('アカウント編集 | 歴史地図')
      expect(page).to have_title('ログイン | 歴史地図')
      expect(page).to have_content('ログインしてください')
    end
  end

  describe "#update" do
    let!(:user) { create(:user) }
    it "無効な入力では、alertが出る" do
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

    it '有効な入力では、"users#show"に遷移し、alertが出る' do
      log_in_as(user)
      visit edit_user_path(user)
      fill_in 'ユーザー名',	with: "add#{user.name}"
      fill_in 'メールアドレス',	with: "add#{user.email}"
      fill_in 'パスワード',	with: "add#{user.password}"
      fill_in 'パスワード（確認）',	with: "add#{user.password}"
      click_on '更新'
      expect(page).to have_title("#{user.name} | 歴史地図")
      expect(page).to have_content('更新しました')
    end
    
  end
end
