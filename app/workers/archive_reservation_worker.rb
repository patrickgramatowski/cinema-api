# frozen_string_literal: true

class ArchiveReservationWorker
  include Sidekiq::Worker

  def perform(reservation_id)
    reservation = Reservations::Repository.new.find(reservation_id)
    return unless reservation.to_archive?

    reservation.update!(status: "archived")
  end
end
