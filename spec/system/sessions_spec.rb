require 'rails_helper'

describe 'Sessions', type: :system do
  describe '#new' do
    it 'ログインボタンを押すとログインページに遷移する' do
      visit root_path
      click_on 'ログイン'
      expect(page).to have_title('ログイン | 歴史地図')
      expect(page).to have_content  'ログイン情報を保持する'
      expect(page).to have_content  'パスワードをお忘れの方'
      expect(page).to have_content  'アカウントをお持ちでない方は新規登録'
    end
  end

  describe '#create' do
    it '無効な入力をすると警告が出る' do
      visit login_path
      fill_in 'メールアドレス',	with: ''
      fill_in 'パスワード',	with: ''
      click_button 'ログイン'
      expect(page).to have_title('ログイン | 歴史地図')
      expect(page).to have_content 'メールアドレスかパスワードが間違っています'
    end

    let!(:user) { create(:user) }

    it 'パスワードは正しいがメールアドレスが間違っている場合、警告が出る' do
      visit login_path
      fill_in 'メールアドレス',	with: ''
      fill_in 'パスワード',	with: user.password
      click_button 'ログイン'
      expect(page).to have_title('ログイン | 歴史地図')
      expect(page).to have_content 'メールアドレスかパスワードが間違っています'
    end

    it 'メールアドレスは正しいがパスワードが間違っている場合、警告が出る' do
      visit login_path
      fill_in 'メールアドレス',	with: user.email
      fill_in 'パスワード',	with: ''
      click_button 'ログイン'
      expect(page).to have_title('ログイン | 歴史地図')
      expect(page).to have_content 'メールアドレスかパスワードが間違っています'
    end

    it '再読み込みするとフラッシュが消える' do
      visit login_path
      fill_in 'メールアドレス',	with: ''
      fill_in 'パスワード',	with: ''
      click_button 'ログイン'
      expect(page).to have_content 'メールアドレスかパスワードが間違っています'
      visit current_path
      expect(page).to have_title('ログイン | 歴史地図')
      expect(page).not_to have_content('メールアドレスかパスワードが間違っています')
    end

    it '有効な入力をするとログインできる' do
      visit login_path
      fill_in 'メールアドレス',	with: user.email
      fill_in 'パスワード',	with: user.password
      click_button 'ログイン'
      expect(page).to have_title('歴史地図')
      expect(page).to have_link '投稿する'
      expect(page).to have_link user.name
    end
  end

  describe '#destroy' do
    let!(:user) { create(:user) }
    
    it 'ログアウトを押すとログアウトする' do
      log_in_as(user)
      click_on user.name
      click_on 'ログアウト'
      expect(page).to have_title('歴史地図')
      expect(page).to have_link '簡単ログイン'
      expect(page).to have_link 'ログイン'
      expect(page).to have_link '新規登録'
    end

    it 'ログアウトした後はログアウトリンクが消える' do
      log_in_as(user)
      click_on user.name
      click_on 'ログアウト'
      visit user_path(user)
      expect(page).not_to have_link 'ログアウト'
    end
  end
end