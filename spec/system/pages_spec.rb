require 'rails_helper'

describe PagesController, type: :system do
  describe '#home' do
    it 'ホームページの項目チェック' do
      visit root_path
      expect(page).to have_title('歴史地図')
      expect(page).to have_content 'トレンド'
    end
  end

  describe 'ヘッダーの検証' do
    let!(:user) { create(:user) }
    it '非ログイン時の項目チェック' do
      visit root_path
      expect(page).to have_link 'applogo'
      expect(page).to have_link '簡単ログイン'
      expect(page).to have_link 'ログイン'
      expect(page).to have_link '新規登録'
    end
    it 'ログイン時の項目チェック' do
      log_in_as(user)
      expect(page).to have_link 'applogo'
      expect(page).to have_link 'post'
      expect(page).to have_link 'user-avatar'
    end
  end

  describe '#map' do
    it 'マップページの項目チェック' do
      visit map_path
      expect(page).to have_title('マップ | 歴史地図')
    end
  end
end
