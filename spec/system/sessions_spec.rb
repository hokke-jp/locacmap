require 'rails_helper'

describe SessionsController, type: :system do
  describe '#new' do
    let!(:user) { create(:user) }

    it '非ログイン時、ログインページに遷移できる' do
      visit root_path
      click_on 'ログイン'
      expect(page).to have_title('ログイン | 歴史地図')
      expect(page).to have_content  'ログイン情報を保持する'
      expect(page).to have_content  'パスワードをお忘れの方'
      expect(page).to have_content  'アカウントをお持ちでない方は新規登録'
    end

    it 'ログイン時、ログインページに遷移できない' do
      log_in_as(user)
      visit login_path
      expect(page).to have_title '歴史地図'
      expect(page).to have_content '既にログインしています'
    end
  end

  describe '#destroy' do
    let!(:user) { create(:user) }

    it 'ログアウトを押すとログアウトする' do
      log_in_as(user)
      click_on 'user-avatar'
      click_on 'ログアウト'
      expect(page).to have_title('歴史地図')
      expect(page).to have_link '簡単ログイン'
      expect(page).to have_link 'ログイン'
      expect(page).to have_link '新規登録'
    end

    it 'ログアウトした後はログアウトリンクが消える' do
      log_in_as(user)
      click_on 'user-avatar'
      click_on 'ログアウト'
      visit user_path(user)
      expect(page).not_to have_link 'ログアウト'
    end
  end

  describe '#easy' do
    let!(:user) { create(:user, :admin) }

    it '簡単ログインを押すと管理ユーザーとしてログインする' do
      visit root_path
      click_on '簡単ログイン'
      expect(page).to have_title '歴史地図'
      expect(page).to have_content '管理ユーザーとしてログインしました'
      expect(page).to have_link 'user-avatar'
    end
  end
end
