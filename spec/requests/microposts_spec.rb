require 'rails_helper'

describe MicropostsController, type: :request do
  let!(:alice) { create(:user) }
  let!(:alice_micropost) { alice.microposts.create(content: 'I am Alice.') }
  let!(:bob) { create(:user) }
  let!(:bob_micropost) { bob.microposts.create(content: 'I am Bob.') }

  describe '#create' do
    it '非ログイン時、microposts#createはできない' do
      expect { post microposts_path, params: { micropost: { content: 'よろしくお願いします。' } } }.not_to change(Micropost, :count)
      expect(response).to redirect_to login_path
    end

    context 'ログイン時' do
      before do
        post login_path, params: { session: { email: alice.email, password: alice.password } }
      end

      it '無効な入力なら、microposts#createはできない' do
        expect { post microposts_path, params: { micropost: { content: '' } } }.not_to change(Micropost, :count)
        expect(response).to render_template('microposts/new')
      end

      it '有効な入力なら、microposts#createはできる' do
        expect { post microposts_path, params: { micropost: { content: 'よろしくお願いします。' } } }.to change { Micropost.count }.by(1)
        expect(response).to redirect_to microposts_url
      end
    end
  end

  describe '#destroy' do
    it '非ログイン時、ユーザーの投稿を削除できない' do
      expect { delete micropost_path(alice) }.not_to change(Micropost, :count)
      expect(response).to redirect_to login_path
    end

    context 'ログイン時' do
      before do
        post login_path, params: { session: { email: alice.email, password: alice.password } }
      end

      it '他のユーザーの投稿を削除できない' do
        expect { delete micropost_path(bob_micropost) }.not_to change(Micropost, :count)
        expect(response).to redirect_to root_path
      end

      it '自分の投稿は削除できる' do
        expect { delete micropost_path(alice_micropost) }.to change { Micropost.count }.by(-1)
        expect(response).to redirect_to root_path
      end
    end
  end
end
