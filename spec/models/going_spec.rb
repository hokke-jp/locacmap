require 'rails_helper'

RSpec.describe Going, type: :model do
  let!(:user) { create(:user) }
  let!(:period) { create(:period) }
  let!(:prefecture) { create(:prefecture) }
  let!(:micropost) { create(:micropost, user_id: user.id, period_id: period.id, prefecture_id: prefecture.id) }
  let(:going) { Going.new(user_id: user.id, micropost_id: micropost.id) }

  it 'user_id、micropost_id両方ある場合OK' do
    expect(going).to be_valid
  end

  it 'user_idがない場合はNG' do
    going.user_id = nil
    expect(going).not_to be_valid
  end

  it 'micropost_idがない場合はNG' do
    going.micropost_id = nil
    expect(going).not_to be_valid
  end

  context 'userとmicropostのgoingを保存した場合' do
    before do
      going.save
    end

    it 'userのgoingにmicropostが含まれる' do
      expect(user.goings.map(&:micropost_id)).to include micropost.id
    end

    it 'micropostのgoingにuserが含まれる' do
      expect(micropost.goings.map(&:user_id)).to include user.id
    end

    it 'goingをdestroyするとどちらも含まれなくなる' do
      Going.destroy(going.id)
      expect(user.goings.map(&:micropost_id)).not_to include micropost.id
      expect(micropost.goings.map(&:user_id)).not_to include user.id
    end
  end
end
