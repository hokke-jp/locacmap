require 'rails_helper'

describe MicropostsController, type: :system do
  describe '#show' do
    let!(:user) { create(:user) }
    let!(:other_user) { create(:user) }
    before do
      @micropost = user.microposts.create(content: 'Hello world!')
    end

    it 'users#showページのユーザー情報が正しく表示されている' do
      visit user_path(user)
      expect(page).to have_title("#{user.name} | 歴史地図")
      expect(page).to have_content user.name
      expect(page).to have_content user.microposts.count
      expect(page).to have_content '投稿数'
    end

    context 'users#showページのユーザー関連リンク' do
      before do
        log_in_as(user)
        visit user_path(user)
      end
    end
    

    context '非ログイン時' do
      it 'ユーザー関連リンクがない' do
        visit user_path(user)
        expect(page).not_to have_link 'ログアウト'
      end
    end

    context 'ログイン時' do
      it 'ログイン時、ユーザー自身のページの場合、ユーザー情報とユーザー関連リンクがある' do
        log_in_as(user)
        visit user_path(user)
        expect(page).to have_title("#{user.name} | 歴史地図")
        expect(page).to have_content user.name
        expect(page).to have_link 'ログアウト'
      end
  
      it 'ログイン時、他のユーザーのページの場合、ユーザー情報のみ見れる' do
        log_in_as(user)
        visit user_path(other_user)
        expect(page).to have_title("#{other_user.name} | 歴史地図")
        expect(page).to have_content other_user.name
        expect(page).not_to have_link 'ログアウト'
      end
    end
  end
end