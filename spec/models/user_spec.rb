require 'rails_helper'

describe User do
  describe '#create' do
    it '全てのカラムに入力があると保存できる' do
      expect(create(:user)).to be_valid
    end

    it 'nameが空の場合、登録できない' do
      expect(build(:user, name: '')).to_not be_valid
    end

    it 'nameが21文字以上の場合、登録できない' do
      expect(build(:user, name: 'a' * 21)).to_not be_valid
    end

    it 'nameが19文字以下の場合、登録できる' do
      expect(build(:user, name: 'a' * 19)).to be_valid
    end

    it 'emailが空の場合、登録できない' do
      expect(build(:user, email: '')).to_not be_valid
    end

    it 'emaiがl一意でない場合、登録できない' do
      # 先にcreateでユーザー保存
      taro = create(:user, email: 'taro@example.com')
      expect(build(:user, email: taro.email)).to_not be_valid
    end

    it 'passwordが空の場合、登録できない' do
      expect(build(:user, password: '',
                          password_confirmation: '')).to_not be_valid
    end

    it 'passwordがスペースの場合、登録できない' do
      expect(build(:user, password: ' ' * 6,
                          password_confirmation: ' ' * 6)).to_not be_valid
    end

    it 'passwordが5文字以下の場合、登録できない' do
      expect(build(:user, password: 'a' * 5,
                          password_confirmation: 'a' * 5)).to_not be_valid
    end

    it 'passwordが6文字以上の場合、登録できる' do
      expect(build(:user, password: 'a' * 6,
                          password_confirmation: 'a' * 6)).to be_valid
    end

    it 'passworとpassword_confirmationが異なる場合、登録できない' do
      expect(build(:user, password: 'password',
                          password_confirmation: 'wardpass')).to_not be_valid
    end
  end
end
