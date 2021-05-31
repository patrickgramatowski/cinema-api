require 'rails_helper'

RSpec.describe Seance, type: :model do
  describe 'validations' do
    subject { build(:seance) }
    context 'has date attribute' do
      it 'must be present' do
        expect(subject).to be_valid
        subject.date = nil
        expect(subject).to_not be_valid
      end
    end

    context 'has time attribute' do
      it 'must be present' do
        expect(subject).to be_valid
        subject.time = nil
        expect(subject).to_not be_valid
      end
    end

    context 'has movie_id attribute' do
      it 'must be present' do
        expect(subject).to be_valid
        subject.movie_id = nil
        expect(subject).to_not be_valid
      end
    end

    context 'has hall_id attribute' do
      it 'must be present' do
        expect(subject).to be_valid
        subject.hall_id = nil
        expect(subject).to_not be_valid
      end
    end
  end
end
