require 'rails_helper'

RSpec.describe TicketDesk, type: :model do
  describe 'validations' do
    subject { build(:ticket_desk) }
    context 'has online attribute' do
      it 'must be present' do
        expect(subject).to be_valid
        subject.online = nil
        expect(subject).to_not be_valid
      end
    end
  end
end
