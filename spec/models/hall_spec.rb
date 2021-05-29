require 'rails_helper'

RSpec.describe Hall, type: :model do
  describe 'validations' do
    subject { build(:hall) }
    context 'has hall attribute' do
      it 'must be present' do
        expect(subject).to be_valid
        subject.hall = nil
        expect(subject).to_not be_valid
      end
    end

    context 'has seats attribute' do
      it 'must be present' do
        expect(subject).to be_valid
        subject.seats = nil
        expect(subject).to_not be_valid
      end
    end
  end
end
