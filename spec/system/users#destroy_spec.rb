require 'rails_helper'

describe 'Users', type: :system do
  describe "#destroy" do
    let!(:admin_user) { create(:user, :admin) }
    let!(:user) { create(:user) }

    it '管理ユーザーは自身の削除リンクがない' do
      log_in_as(admin_user)
      visit edit_user_path(admin_user)
      expect(page).not_to have_link('アカウント削除')
    end

    it '管理ユーザーは他のユーザーの削除リンクがある' do
      log_in_as(admin_user)
      visit users_path
      expect(page).to have_link('delete')
    end

    it 'ユーザーは自身の削除リンクがある' do
      log_in_as(user)
      visit edit_user_path(user)
      expect(page).to have_link('アカウント削除')
    end

    it 'ユーザーは他のユーザーの削除リンクがない' do
      log_in_as(user)
      visit users_path
      expect(page).not_to have_link('delete')
    end
  end
end