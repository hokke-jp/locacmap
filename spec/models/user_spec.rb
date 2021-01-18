require 'rails_helper'

describe User do
  it '有効な入力だとOK' do
    expect(build(:user)).to be_valid
  end

  it 'nameが空だとNG' do
    expect(build(:user, name: '')).not_to be_valid
  end

  it 'nameが21文字以上だとNG' do
    expect(build(:user, name: 'a' * 21)).not_to be_valid
  end

  it 'nameが19文字以下だとOK' do
    expect(build(:user, name: 'a' * 19)).to be_valid
  end

  it 'emailが空だとNG' do
    expect(build(:user, email: '')).not_to be_valid
  end

  it 'emailが一意でないとNG' do
    # 先にcreateでユーザー保存
    create(:user, email: 'alice@example.com')
    expect(build(:user, email: 'alice@example.com')).not_to be_valid
  end

  it 'emailが有効なフォーマットならOK' do
    valid_addresses  = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
      first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      expect(build(:user, email: valid_address)).to be_valid
    end
  end

  it 'emailが無効なフォーマットならNG' do
    invalid_addresses  = %w[user@example,com user_at_foo.org user.name@example.
      foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      expect(build(:user, email: invalid_address)).not_to be_valid
    end
  end

  it 'passwordが空だとNG' do
    expect(build(:user, password: '',
                        password_confirmation: '')).not_to be_valid
  end

  it 'passwordがスペースだけだとNG' do
    expect(build(:user, password: ' ' * 6,
                        password_confirmation: ' ' * 6)).not_to be_valid
  end

  it 'passwordが5文字以下だとNG' do
    expect(build(:user, password: 'a' * 5,
                        password_confirmation: 'a' * 5)).not_to be_valid
  end

  it 'passwordが6文字以上だとOK' do
    expect(build(:user, password: 'a' * 6,
                        password_confirmation: 'a' * 6)).to be_valid
  end

  it 'passworとpassword_confirmationが異なるとNG' do
    expect(build(:user, password: 'password',
                        password_confirmation: 'wardpass')).not_to be_valid
  end

  describe 'リレーションシップ検証' do
    let!(:alice) { create(:user) }
    let!(:bob) { create(:user) }

    it 'デフォルトでは誰もフォローしていない' do
      expect(alice.following?(bob)).to be false
    end

    context 'aliceがbobをフォローした場合' do
      before do
        alice.follow(bob)
      end

      it 'aliceのフォローにbobが含まれる' do
        expect(alice.following?(bob)).to be true
      end
  
      it 'bobのフォロワーにaliceが含まれる' do
        expect(bob.followers.include?(alice)).to be true
      end
  
      it 'bobのフォローを外すと、aliceのフォローに含まれなくなる' do
        alice.unfollow(bob)
        expect(alice.following?(bob)).to be false
      end
    end
  end
end
