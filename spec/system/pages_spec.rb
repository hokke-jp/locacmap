require 'rails_helper'

describe PagesController, type: :system do
  context '非ログイン時' do
    it 'ヘッダーのリンクの検証' do
      visit root_path
      expect(page).to have_link 'applogo'
      expect(page).to have_link '簡単ログイン'
      expect(page).to have_link 'ログイン'
      expect(page).to have_link '新規登録'
    end
  end

  context 'ログイン時' do
    let!(:user) { create(:user) }
    it 'ヘッダーのリンクの検証' do
      log_in_as(user)
      expect(page).to have_link 'applogo'
      expect(page).to have_link 'post'
      expect(page).to have_link 'gravatar_icon'
    end
  end
end
