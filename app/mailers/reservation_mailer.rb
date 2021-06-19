class ReservationMailer < ApplicationMailer
  default from: 'patryk.gramatowski@monterail.com'

  def reservation_information(email, reservation)
    @email = email
    @reservation = reservation
    @tickets = @reservation.tickets
    mail(to: @email, subject: 'MonteCinema - Reservation information')
  end

  def cancel_reservation(email, reservation)
    @email = email
    @reservation = reservation
    mail(to: @email, subject: 'MonteCinema - Cancelled Reservation') 
  end
end
