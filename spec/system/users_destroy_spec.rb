require 'rails_helper'

describe UsersController, type: :system do
  describe '#destroy' do
    let!(:admin_user) { create(:user, :admin) }
    let!(:user) { create(:user) }
    before do
      user.follow(admin_user)
      admin_user.follow(user)
    end

    context '管理ユーザーの場合' do
      before do
        log_in_as(admin_user)
      end

      it '管理ユーザーは自身の削除リンクがない' do
        visit edit_user_path(admin_user)
        expect(page).not_to have_link('アカウント削除')
      end

      it '管理ユーザーは他のユーザーの削除リンクがある' do
        visit user_path(admin_user)
        all('a.number')[2].click
        expect(page).to have_link('delete')
      end
    end

    context '非管理ユーザーの場合' do
      before do
        log_in_as(user)
      end

      it 'ユーザーは自身の削除リンクがある' do
        visit edit_user_path(user)
        expect(page).to have_link('アカウント削除')
      end

      it 'ユーザーは他のユーザーの削除リンクがない' do
        visit user_path(user)
        all('a.number')[2].click
        expect(page).not_to have_link('delete')
      end
    end
  end
end
