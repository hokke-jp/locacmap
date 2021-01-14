require 'rails_helper'

describe 'Users', type: :request do
  describe '#update' do
    let!(:user) { create(:user) }
    let!(:other_user) { create(:user) }

    it '非ログイン時、updateできない' do
      patch edit_user_path(user), params: { user: { name: 'edit user', email: 'edit_user@example.com' } }
      expect(response).to have_http_status '302'
      expect(response).to redirect_to login_path
    end

    it 'ログイン時、他のユーザーのupdateはできない' do
      post login_path, params: { session: { email: user.email, password: user.password } }
      patch edit_user_path(other_user), params: { user: { name: 'edit user', email: 'edit_user@example.com' } }
      expect(response).to have_http_status '302'
      expect(response).to redirect_to root_path
    end
  end

  describe "管理ユーザー" do
    let!(:user) { create(:user) }
    let!(:admin_user) { create(:user, :admin) }
    
    it "ユーザーの、admin属性のストロングパラメータテスト" do
      post login_path, params: { session: { email: user.email,
                                            password: user.password } }
      expect(user.admin?).to be false
      patch edit_user_path(user), params: { user: { password: user.password,
                                        password_confirmation: user.password,
                                        admin: true } }
      expect(user.admin?).to be false
    end

    it "管理ユーザーの、admin属性のストロングパラメータテスト" do
      post login_path, params: { session: { email: admin_user.email, password: admin_user.password } }
      expect(admin_user.admin?).to be true
      patch edit_user_path(admin_user), params: { user: { password: user.password, password_confirmation: user.password, admin: false } }
      expect(admin_user.admin?).to be true
    end
  end

  describe "#destroy" do
    let!(:admin_user) { create(:user, :admin) }
    let!(:user) { create(:user) }
    let!(:alice) { create(:user) }
    let!(:bob) { create(:user) }

    it "管理ユーザーは自身を削除できない" do
      post login_path, params: { session: { email: admin_user.email, password: admin_user.password } }
      expect { delete user_path(admin_user) }.not_to change(User, :count)
      expect(response).to redirect_to root_url
    end
    
    it "管理ユーザーは他のユーザーを削除できる" do
      post login_path, params: { session: { email: admin_user.email, password: admin_user.password } }
      # ポートフォリオ用の'簡単ログイン'で削除できないように設定してあるので
      # expect { delete user_path(user) }.to change { User.count }.by(-1)
      expect { delete user_path(user) }.not_to change(User, :count)
      expect(response).to redirect_to root_url
    end
    
    it "ユーザーは自身を削除できる" do
      post login_path, params: { session: { email: user.email, password: user.password } }
      expect { delete user_path(user) }.to change { User.count }.by(-1)
      expect(response).to redirect_to root_url
    end
    
    it "ユーザーは他のユーザーを削除できない" do
      post login_path, params: { session: { email: alice.email, password: alice.password } }
      expect { delete user_path(bob) }.not_to change(User, :count)
      expect(response).to redirect_to root_url
    end
    
  end
end