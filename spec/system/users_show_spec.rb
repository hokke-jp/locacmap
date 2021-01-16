require 'rails_helper'

describe UsersController, type: :system do
  describe '#show' do
    let!(:user) { create(:user) }
    let!(:other_user) { create(:user) }
    before do
      @micropost = user.microposts.create(content: 'Hello world!')
    end

    it 'users#showページのユーザー情報の各項目チェック' do
      visit user_path(user)
      expect(page).to have_title("#{user.name} | 歴史地図")
      expect(page).to have_selector( 'img[alt="gravatar_icon"]' )
      expect(page).to have_content user.name
      expect(page).to have_content user.microposts.count
      expect(page).to have_content '投稿数'
    end

    context '非ログイン時' do
      it 'ユーザー情報はあるがユーザー関連リンクがない' do
        visit user_path(user)
        expect(page).to have_selector( 'img[alt="gravatar_icon"]' )
        expect(page).not_to have_link 'ログアウト'
      end
    end

    context 'ログイン時' do
      before do
        log_in_as(user)
      end

      it 'ユーザー関連リンクの各項目チェック' do
        visit user_path(user)
        expect(page).to have_link 'ユーザー情報'
        expect(page).to have_link 'ユーザー一覧'
        expect(page).to have_link 'お気に入りの記事'
        expect(page).to have_link 'アカウント編集'
        expect(page).to have_link 'ログアウト'
      end

      it 'ユーザー自身のページの場合、ユーザー情報とユーザー関連リンクがある' do
        visit user_path(user)
        expect(page).to have_title("#{user.name} | 歴史地図")
        expect(page).to have_content user.name
        expect(page).to have_link 'ログアウト'
      end
  
      it '他のユーザーのページの場合、ユーザー情報はあるがユーザー関連リンクはない' do
        visit user_path(other_user)
        expect(page).to have_title("#{other_user.name} | 歴史地図")
        expect(page).to have_content other_user.name
        expect(page).not_to have_link 'ログアウト'
      end
    end
  end
end