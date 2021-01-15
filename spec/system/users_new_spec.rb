require 'rails_helper'

describe 'Users', type: :system do
  describe '#new' do
    it '非ログイン時、"users#new"に遷移できる' do
      visit root_path
      click_on '新規登録'
      expect(page).to have_title('アカウント作成 | 歴史地図')
      expect(page).to have_content 'アカウント作成'
      expect(page).to have_link '登録'
    end
  end
end
