module Api
  class TicketsController < ApplicationController
    # HTTP GET list of tickets
    def index
      render jsonapi: Tickets::UseCases::FetchAll.new.call
    end

    # HTTP GET ticket by id
    def show
      render jsonapi: Tickets::UseCases::FetchOne.new.call(id: params[:id])
    end

    # HTTP POST create ticket
    def create
      @ticket = Tickets::UseCases::Create.new.call(params: ticket_params)

      if @ticket.valid?
        render jsonapi: @ticket, status: :created
      else
        render jsonapi_errors: @ticket.errors, status: :unprocessable_entity
      end
    end

    # HTTP PUT update the ticket
    def update
      @ticket = Tickets::UseCases::Update.new.call(id: params[:id], params: ticket_params)

      if @ticket.valid?
        render jsonapi: @ticket
      else
        render jsonapi_errors: @ticket.errors, status: :unprocessable_entity
      end
    end

    # HTTP DELETE destroy the ticket
    def destroy
      Tickets::UseCases::Delete.new.call(id: params[:id])
    end

    private

    def ticket_params
      params.require(:ticket).permit(:price, :seat, :ticket_type, :reservation_id)
    end
  end
end
