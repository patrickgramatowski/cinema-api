# frozen_string_literal: true

class CancelReservationWorker
  include Sidekiq::Worker

  def perform(reservation_id)
    reservation = Reservations::Repository.new.find(reservation_id)
    return unless reservation.expired?

    reservation.update!(status: "cancelled")
    ReservationMailer.cancel_reservation(User.find(id: reservation.user_id).email, reservation).deliver_now
  end
end
