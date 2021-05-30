require 'rails_helper'

RSpec.describe Movie, type: :model do
  describe 'validations' do
    subject { build(:movie) }
    context 'has title attribute' do
      it 'must be present' do
        expect(subject).to be_valid
        subject.title = nil
        expect(subject).to_not be_valid
      end
    end

    context 'has genre attribute' do
      it 'must be present' do
        expect(subject).to be_valid
        subject.genre = nil
        expect(subject).to_not be_valid
      end
    end

    context 'has length attribute' do
      it 'must be present' do
        expect(subject).to be_valid
        subject.length = nil
        expect(subject).to_not be_valid
      end
    end
  end
end
