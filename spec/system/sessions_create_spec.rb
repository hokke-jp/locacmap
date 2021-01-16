require 'rails_helper'

describe SessionsController, type: :system do
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
      expect(page).to have_link 'gravatar_icon'
    end
  end
end
