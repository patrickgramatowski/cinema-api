require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    subject { build(:user) }
    context 'has email attribute' do
      it 'must be present' do
        expect(subject).to be_valid
        subject.email = nil
        expect(subject).to_not be_valid
      end
    end

    context 'has password attribute' do
      it 'must be present' do
        expect(subject).to be_valid
        subject.password = nil
        expect(subject).to_not be_valid
      end
    end
  end
end
