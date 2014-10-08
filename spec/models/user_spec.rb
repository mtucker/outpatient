require 'rails_helper'

RSpec.describe User, :type => :model do

  context 'being deleted' do

    let(:user) { create :user }

    it 'does not remove the record' do

      id = user.id
      user.destroy

      expect(User.with_deleted.find(id)).not_to be_nil

    end

    it 'sets deleted_at' do

      user.destroy
      expect(user.deleted_at).not_to be_nil

    end

    it 'cannot be found with standard query' do

      id = user.id
      user.destroy
      expect{ User.find(id) }.to raise_error(ActiveRecord::RecordNotFound)

    end

  end

end
