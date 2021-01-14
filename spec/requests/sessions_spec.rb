require 'rails_helper'

describe 'Sessions', type: :request do
  describe 'remember me' do
    let!(:user) { create(:user) }
    
    it 'remember meがonの場合、cookie保存' do
      post login_path, params: { session: { email: user.email, password: user.password, remember_me: '1' } }
      expect(response).to redirect_to root_url
      expect(response.cookies['remember_token']).to_not eq nil
    end

    it 'remember meがoffの場合、cookieはnil' do
      post login_path, params: { session: { email: user.email, password: user.password, remember_me: '0' } }
      expect(response).to redirect_to root_url
      expect(response.cookies['remember_token']).to eq nil
    end

    it 'ログアウトした場合、cookieはnil' do
      post login_path, params: { session: { email: user.email, password: user.password, remember_me: '1' } }
      delete logout_path
      expect(response.cookies['remember_token']).to eq nil
    end

    it 'ログアウトし、再びログインした場合、cookieはnil' do
      post login_path, params: { session: { email: user.email, password: user.password, remember_me: '1' } }
      delete logout_path
      post login_path, params: { session: { email: user.email, password: user.password } }
      expect(response.cookies['remember_token']).to eq nil
    end
  end
end
