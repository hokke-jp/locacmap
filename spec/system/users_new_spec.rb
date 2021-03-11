require 'rails_helper'

describe UsersController, type: :system do
  describe '#new' do
    let!(:user) { create(:user) }

    it '非ログイン時、新規登録ページに遷移できる' do
      visit root_path
      click_on '新規登録'
      expect(page).to have_title 'アカウント作成 | 歴史地図'
      expect(page).to have_content 'アカウント作成'
      expect(page).to have_link '登録'
    end

    it 'ログイン時、新規登録ページに遷移できない' do
      log_in_as(user)
      visit signup_path
      expect(page).to have_title '歴史地図'
      expect(page).to have_content '既にログインしています'
    end
  end
end
