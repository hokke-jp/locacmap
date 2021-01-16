require 'rails_helper'

describe SessionsController, type: :system do
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

  describe '#destroy' do
    let!(:user) { create(:user) }

    it 'ログアウトを押すとログアウトする' do
      log_in_as(user)
      click_on 'gravatar_icon'
      click_on 'ログアウト'
      expect(page).to have_title('歴史地図')
      expect(page).to have_link '簡単ログイン'
      expect(page).to have_link 'ログイン'
      expect(page).to have_link '新規登録'
    end

    it 'ログアウトした後はログアウトリンクが消える' do
      log_in_as(user)
      click_on 'gravatar_icon'
      click_on 'ログアウト'
      visit user_path(user)
      expect(page).not_to have_link 'ログアウト'
    end
  end
end
