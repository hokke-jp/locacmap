require 'rails_helper'

describe 'relationship', type: :system do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:favorite_user) { create(:user) }
  before do
    Relationship.create(follower_id: user.id, followed_id: favorite_user.id)
  end

  context '非ログインユーザーの場合' do
    before do
      visit user_path(user)
    end

    it '登録ボタンが表示される' do
      expect(page).to have_button 'ユーザーをお気に入りに登録'
    end

    it '登録ボタンを押すとログインを要求される' do
      click_on 'ユーザーをお気に入りに登録'
      expect(page).to have_title 'ログイン | 歴史地図'
      expect(page).to have_content 'ログインしてください'
    end
  end

  context 'ログインユーザーの場合' do
    before do
      log_in_as(user)
    end

    it 'お気に入り登録していなければ登録ボタンが表示される' do
      visit user_path(other_user)
      expect(page).to have_button 'ユーザーをお気に入りに登録'
    end

    it 'お気に入り登録していれば解除ボタンが表示される' do
      visit user_path(favorite_user)
      expect(page).to have_button 'お気に入り解除'
    end

    context 'お気に入り登録ボタンをクリックすると' do
      before do
        visit user_path(other_user)
        click_on 'ユーザーをお気に入りに登録'
      end

      it 'userのお気に入りに登録される' do
        sleep 0.5
        expect(user.following.ids).to include other_user.id
      end

      it 'お気に入り解除ボタンが表示される' do
        expect(page).to have_button 'お気に入り解除'
      end
    end

    context 'お気に入り解除ボタンをクリックすると' do
      before do
        visit user_path(favorite_user)
      end

      it 'confirmダイアログが表示される' do
        page.dismiss_confirm('お気に入り登録を解除します。') do
          click_on 'お気に入り解除'
        end
      end

      it 'userのお気に入りから外れる' do
        page.accept_confirm do
          click_on 'お気に入り解除'
        end
        sleep 0.5
        expect(user.following.ids).not_to include favorite_user.id
      end

      it 'お気に入りボタンが表示される' do
        page.accept_confirm do
          click_on 'お気に入り解除'
        end
        expect(page).to have_button 'ユーザーをお気に入りに登録'
      end
    end
  end
end
