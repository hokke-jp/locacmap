require 'rails_helper'

describe 'Users', type: :system do
  describe '#new' do
    it '新規登録ボタンを押すとアカウント作成ページに遷移する' do
      visit root_path
      click_on '新規登録'
      expect(page).to have_title('アカウント作成 | 歴史地図')
      expect(page).to have_content 'アカウント作成'
      expect(page).to have_link '登録'
    end
  end

  describe '#create' do
    let!(:user) { build(:user) }
    it '無効な入力をすると警告が出る' do
      visit signup_path
      fill_in 'ユーザー名',	with: 'A' * 21
      # クライアント側検証が発生し登録ボタンを押せなくなるためmailは有効にする
      fill_in 'メールアドレス',	with: user.email
      fill_in 'パスワード',	with: 'foo'
      fill_in 'パスワード（確認）',	with: 'foobar'
      expect { click_on '登録' }.not_to change(User, :count)
      expect(page).to have_title('アカウント作成 | 歴史地図')
      expect(page).to have_content('3つの入力エラー')
    end

    it '再読み込みするとフラッシュが消える(失敗時)' do
      visit signup_path
      fill_in 'ユーザー名',	with: 'A' * 21
      fill_in 'メールアドレス',	with: user.email
      fill_in 'パスワード',	with: 'foo'
      fill_in 'パスワード（確認）',	with: 'foobar'
      click_on '登録'
      expect(page).to have_content('3つの入力エラー')
      visit current_path
      expect(page).to have_title('アカウント作成 | 歴史地図')
      expect(page).not_to have_content('3つの入力エラー')
    end

    it '有効な入力をするとメールが送られる' do
      visit signup_path
      fill_in 'ユーザー名',	with: user.name
      fill_in 'メールアドレス',	with: user.email
      fill_in 'パスワード',	with: user.password
      fill_in 'パスワード（確認）',	with: user.password
      expect { click_on '登録' }.to change { User.count }.by(1)
      expect(page).to have_title('歴史地図')
      expect(page).to have_content('確認メールを送信しました')
    end

    it '再読み込みするとフラッシュが消える(成功時)' do
      visit signup_path
      fill_in 'ユーザー名',	with: user.name
      fill_in 'メールアドレス',	with: user.email
      fill_in 'パスワード',	with: user.password
      fill_in 'パスワード（確認）',	with: user.password
      click_on '登録'
      expect(page).to have_content('確認メールを送信しました')
      visit current_path
      expect(page).to have_title('歴史地図')
      expect(page).not_to have_content('確認メールを送信しました')
    end
  end

  # describe '登録変更' do
  #   let!(:alice) { create(:user) }
  #   it '有効な入力をすると更新できる' do
  #     visit root_path
  #     fill_in 'テキスト',	with: User.last.id
  #     expect(subject).to 0
  #   end
  # end
end
