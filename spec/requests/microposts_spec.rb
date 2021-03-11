require 'rails_helper'

describe MicropostsController, type: :request do
  let!(:period) { create(:period) }
  let!(:prefecture) { create(:prefecture) }
  let!(:micropost) { create(:micropost, period_id: period.id, prefecture_id: prefecture.id) }
  let!(:other_micropost) { create(:micropost, period_id: period.id, prefecture_id: prefecture.id) }

  describe '#create' do
    it '非ログイン時、投稿はできない' do
      expect do
        post microposts_path,
             params: { micropost: { title: 'テスト投稿', content: 'テスト説明文', period_id: micropost.period_id, prefecture_id: micropost.prefecture_id,
                                    latlng: '(37, 137)' } }
      end.not_to change(Micropost, :count)
      expect(response).to redirect_to login_path
    end

    context 'ログイン時' do
      before do
        post login_path, params: { session: { email: micropost.user.email, password: micropost.user.password } }
      end

      it '無効な入力なら、投稿はできない' do
        expect do
          post microposts_path, params: { micropost: { title: '', content: '', period_id: '', prefecture_id: '', latlng: '' } }
        end.not_to change(Micropost, :count)
        expect(response).to render_template('microposts/new')
      end

      it '有効な入力なら、投稿はできる' do
        expect do
          post microposts_path,
               params: { micropost: { title: 'テスト投稿', content: 'テスト説明文', period_id: micropost.period_id, prefecture_id: micropost.prefecture_id,
                                      latlng: '(37, 137)' } }
        end.to change {
                 Micropost.count
               }.by(1)
        expect(response).to redirect_to microposts_url
      end
    end
  end

  describe '#destroy' do
    it '非ログイン時、ユーザーの投稿を削除できない' do
      expect { delete micropost_path(micropost.user) }.not_to change(Micropost, :count)
      expect(response).to redirect_to login_path
    end

    context 'ログイン時' do
      before do
        post login_path, params: { session: { email: micropost.user.email, password: micropost.user.password } }
      end

      it '他のユーザーの投稿を削除できない' do
        expect { delete micropost_path(other_micropost) }.not_to change(Micropost, :count)
        expect(response).to redirect_to root_path
      end

      it '自分の投稿は削除できる' do
        expect { delete micropost_path(micropost) }.to change { Micropost.count }.by(-1)
        expect(response).to redirect_to root_path
      end
    end
  end
end
