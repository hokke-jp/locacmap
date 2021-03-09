require 'rails_helper'

describe UsersController, type: :system do
  describe '#show' do
    let!(:user) { create(:user) }
    let!(:other_user) { create(:user) }

    it 'ユーザーページの項目チェック' do
      visit user_path(user)
      expect(page).to have_title("#{user.name} | 歴史地図")
      expect(page).to have_selector('img[alt="user-avatar"]')
      expect(page).to have_content user.name
      # expect(page).to have_link user.microposts.count
      # expect(page).to have_link user.goings.count
      # expect(page).to have_link user.following.count
      expect(page).to have_content user.created_at.strftime("%Y/%m/%d")
      expect(page).to have_button 'ユーザーをお気に入りに登録'
    end

    context 'ログイン時' do
      before do
        log_in_as(user)
      end

      it 'ユーザー自身のページの場合、ユーザー関連リンクの項目チェック' do
        visit user_path(user)
        expect(page).to have_link 'アカウント編集'
        expect(page).to have_link 'ログアウト'
      end

      it '他のユーザーのページの場合、お気に入り登録ボタンがある' do
        visit user_path(other_user)
        expect(page).to have_title("#{other_user.name} | 歴史地図")
        expect(page).to have_content other_user.name
        expect(page).to have_button 'ユーザーをお気に入りに登録'
      end
    end
  end
end
