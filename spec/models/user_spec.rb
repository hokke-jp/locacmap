require 'rails_helper'

describe UsersController do
  it '有効な入力だとOK' do
    expect(build(:user)).to be_valid
  end

  it 'nameが空だとNG' do
    expect(build(:user, name: '')).to_not be_valid
  end

  it 'nameが21文字以上だとNG' do
    expect(build(:user, name: 'a' * 21)).to_not be_valid
  end

  it 'nameが19文字以下だとOK' do
    expect(build(:user, name: 'a' * 19)).to be_valid
  end

  it 'emailが空だとNG' do
    expect(build(:user, email: '')).to_not be_valid
  end

  it 'emaiがl一意でないとNG' do
    # 先にcreateでユーザー保存
    create(:user, email: 'alice@example.com')
    expect(build(:user, email: 'alice@example.com')).to_not be_valid
  end

  it 'passwordが空だとNG' do
    expect(build(:user, password: '',
                        password_confirmation: '')).to_not be_valid
  end

  it 'passwordがスペースだけだとNG' do
    expect(build(:user, password: ' ' * 6,
                        password_confirmation: ' ' * 6)).to_not be_valid
  end

  it 'passwordが5文字以下だとNG' do
    expect(build(:user, password: 'a' * 5,
                        password_confirmation: 'a' * 5)).to_not be_valid
  end

  it 'passwordが6文字以上だとOK' do
    expect(build(:user, password: 'a' * 6,
                        password_confirmation: 'a' * 6)).to be_valid
  end

  it 'passworとpassword_confirmationが異なるとNG' do
    expect(build(:user, password: 'password',
                        password_confirmation: 'wardpass')).to_not be_valid
  end
end
