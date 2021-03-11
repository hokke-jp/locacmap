require 'rails_helper'

RSpec.describe User, type: :model do
  it '有効な入力ならOK' do
    expect(build(:user)).to be_valid
  end

  it 'nameが空ならNG' do
    expect(build(:user, name: '')).not_to be_valid
  end

  it 'nameが21文字以上ならNG' do
    expect(build(:user, name: 'a' * 21)).not_to be_valid
  end

  it 'nameが19文字以下ならOK' do
    expect(build(:user, name: 'a' * 19)).to be_valid
  end

  it 'emailが空ならNG' do
    expect(build(:user, email: '')).not_to be_valid
  end

  it 'emailが一意でないならNG' do
    # 予めcreateでユーザー保存
    create(:user, email: 'alice@example.com')
    expect(build(:user, email: 'alice@example.com')).not_to be_valid
  end

  it 'emailが有効なフォーマットならOK' do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      expect(build(:user, email: valid_address)).to be_valid
    end
  end

  it 'emailが無効なフォーマットならNG' do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      expect(build(:user, email: invalid_address)).not_to be_valid
    end
  end

  it 'passwordが空ならNG' do
    expect(build(:user, password: '',
                        password_confirmation: '')).not_to be_valid
  end

  it 'passwordがスペースだけならNG' do
    expect(build(:user, password: ' ' * 6,
                        password_confirmation: ' ' * 6)).not_to be_valid
  end

  it 'passwordが5文字以下ならNG' do
    expect(build(:user, password: 'a' * 5,
                        password_confirmation: 'a' * 5)).not_to be_valid
  end

  it 'passwordが6文字以上ならOK' do
    expect(build(:user, password: 'a' * 6,
                        password_confirmation: 'a' * 6)).to be_valid
  end

  it 'passworとpassword_confirmationが異なるとNG' do
    expect(build(:user, password: 'password',
                        password_confirmation: 'wardpass')).not_to be_valid
  end
end
