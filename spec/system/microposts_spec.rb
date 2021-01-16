require 'rails_helper'

describe MicropostsController, type: :system do
  describe '#show, #destroy' do
    let(:user) { create(:user) }
    let(:ten_post_user) { create(:user) }
    let!(:no_post_user) { create(:user) }
    before do
      (1..11).each do |_i|
        user.microposts.create(content: "これが#{_i}回目の投稿です")
      end
      (1..10).each do |_i|
        ten_post_user.microposts.create(content: "これが#{_i}回目の投稿です")
      end
    end

    it '投稿が一つもないユーザーの場合' do
      visit micropost_path(no_post_user)
      expect(page).to have_content('このユーザーの投稿はまだありません。')
      expect(page).to have_title("#{no_post_user.name}の投稿 | 歴史地図")
    end

    it '投稿があるユーザーの各項目チェック' do
      visit micropost_path(user)
      expect(page).to have_title("#{user.name}の投稿 | 歴史地図")
      expect(page).to have_content("投稿数：#{user.microposts.count}")
      expect(page).to have_content(user.name)
      expect(page).to have_content(user.microposts.first.content)
      expect(page).to have_content('1分未満前の投稿')
    end

    context '投稿があるユーザー' do
      it '投稿数が10以下のユーザーの場合、ページネーションが表示されない' do
        visit micropost_path(ten_post_user)
        expect(page).not_to have_selector 'div.pagination'
      end

      it '投稿数が11以上のユーザーの場合、ページネーションが表示される' do
        visit micropost_path(user)
        expect(page).to have_selector 'div.pagination'
      end
    end

    context 'ログイン時' do
      before do
        log_in_as(user)
      end
    end
    
  end
end
