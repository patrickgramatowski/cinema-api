require 'rails_helper'

RSpec.describe Ticket, type: :model do
  describe 'validations' do
    subject { build(:ticket) }
    context 'has price attribute' do
      it 'must be present' do
        expect(subject).to be_valid
        subject.price = nil
        expect(subject).to_not be_valid
      end
    end

    context 'has seat attribute' do
      it 'must be present' do
        expect(subject).to be_valid
        subject.seat = nil
        expect(subject).to_not be_valid
      end
    end

    context 'has ticket_type attribute' do
      it 'must be present' do
        expect(subject).to be_valid
        subject.ticket_type = nil
        expect(subject).to_not be_valid
      end
    end
  end
end
