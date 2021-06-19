require "rails_helper"

RSpec.describe ReservationMailer, type: :mailer do
  include ActiveJob::TestHelper

  let(:user){ create(:user) }
  let(:seance) { create(:seance, date: Time.now + 1.days) }
  let(:reservation) { create(:reservation, user_id: user.id, seance_id: seance.id, status: "pending") }

  it 'reservation_information is sent' do
      expect {
          perform_enqueued_jobs do
              ReservationMailer.reservation_information(user.email, reservation).deliver_later
          end
      }.to change { ActionMailer::Base.deliveries.size }.by(1)
  end

  it 'reservation_information is sent to the right user' do
      perform_enqueued_jobs do
        ReservationMailer.reservation_information(user.email, reservation).deliver_later
      end

      mail = ActionMailer::Base.deliveries.last
      expect(mail.to[0]).to eq user.email
  end

  it 'cancel_reservation is sent' do
    expect {
        perform_enqueued_jobs do
            ReservationMailer.cancel_reservation(user.email, reservation).deliver_later
        end
    }.to change { ActionMailer::Base.deliveries.size }.by(1)
  end

  it 'cancel_reservation is sent to the right user' do
      perform_enqueued_jobs do
        ReservationMailer.reservation_information(user.email, reservation).deliver_later
      end

      mail = ActionMailer::Base.deliveries.last
      expect(mail.to[0]).to eq user.email
  end
end
