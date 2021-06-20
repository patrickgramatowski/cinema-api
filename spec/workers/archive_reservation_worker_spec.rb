require 'rails_helper'

Sidekiq::Testing.fake!

RSpec.describe ArchiveReservationWorker, type: :worker do
  describe 'testing worker' do
    let(:archive_date) { (Time.zone.today + 1.days).to_datetime }
    let(:reservation) { create(:reservation) }
    let(:scheduled_job) { described_class.perform_at(archive_date, reservation.id) }

    it 'ArchiveReservationWorker jobs are enqueued in the scheduled queue' do
      described_class.perform_async
      expect("default").to eql(described_class.queue)
    end

    it 'goes into the jobs array for testing environment' do
      expect do
        described_class.perform_async
      end.to change(described_class.jobs, :size).by(1)
      described_class.new.perform(reservation.id)
    end

    it 'occurs at expected time' do
      scheduled_job
      expect(described_class.jobs.last['jid'].include?(scheduled_job)).to eql(true)
      expect(described_class).to have_enqueued_sidekiq_job(reservation.id)
    end
  end
end