require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe 'validations' do
    subject { build(:reservation) }
    context 'has seance_id attribute' do
      it 'must be present' do
        expect(subject).to be_valid
        subject.seance_id = nil
        expect(subject).to_not be_valid
      end
    end

    context 'has ticket_desk_id attribute' do
      it 'must be present' do
        expect(subject).to be_valid
        subject.ticket_desk_id = nil
        expect(subject).to_not be_valid
      end
    end

    context 'has status attribute' do
      it 'must be present' do
        expect(subject).to be_valid
        subject.status = nil
        expect(subject).to_not be_valid
      end
    end
  end
end
