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
      expect(page).to have_content user.created_at.strftime('%Y/%m/%d')
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

    describe '投稿数、チェック記事、お気に入りユーザーの動作チェック' do
      let!(:period) { create(:period) }
      let!(:prefecture) { create(:prefecture) }
      let!(:micropost1) { create(:micropost, user_id: user.id, period_id: period.id, prefecture_id: prefecture.id) }
      let!(:micropost2) { create(:micropost, user_id: user.id, period_id: period.id, prefecture_id: prefecture.id) }
      let!(:micropost3) { create(:micropost, user_id: other_user.id, period_id: period.id, prefecture_id: prefecture.id) }
      before do
        user.goings.create(micropost_id: micropost1.id)
        user.goings.create(micropost_id: micropost2.id)
        user.goings.create(micropost_id: micropost3.id)
        user.follow(other_user)
        visit user_path(user)
      end

      it 'ユーザーページの動的項目チェック' do
        expect(all('a.number')[0].text).to have_content user.microposts.count
        expect(all('a.number')[1].text).to have_content user.goings.count
        expect(all('a.number')[2].text).to have_content user.following.count
      end

      it '投稿数をクリックすると自分の投稿と地図リンクが表示される' do
        all('a.number')[0].click
        expect(page).to have_content micropost1.title
        expect(page).to have_content micropost2.title
        expect(page).to have_link '地図で見る'
      end

      it 'チェック記事をクリックするとチェックした記事と地図リンクが表示される' do
        all('a.number')[1].click
        expect(page).to have_content micropost1.title
        expect(page).to have_content micropost2.title
        expect(page).to have_content micropost3.title
        expect(page).to have_link '地図で見る'
      end

      it 'お気に入りユーザーをクリックするとお気に入り登録したユーザーとそのユーザーの投稿と地図リンクが表示される' do
        all('a.number')[2].click
        expect(all('a.truncate')[0].text).to have_content micropost3.user.name
        expect(page).to have_content micropost3.title
        expect(page).to have_link '地図で見る'
      end
    end
  end
end
