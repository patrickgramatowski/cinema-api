module Api
  class TicketDesksController < ApplicationController
    # HTTP GET list of ticket_desks
    def index
      render jsonapi: TicketDesk.all
      #render jsonapi: Ticket_desks::UseCases::FetchAll.new.call
    end

    # HTTP GET ticket_desk by id
    def show
      render jsonapi: TicketDesk.find(params[:id])
      #render jsonapi: Ticket_desks::UseCases::FetchOne.new.call(id: params[:id])
    end

    # HTTP POST create ticket_desk
    def create
      @ticket_desk = Ticket_desks::UseCases::Create.new.call(params: ticket_desk_params)

      if @ticket_desk.valid?
        render jsonapi: @ticket_desk, status: :created
      else
        render jsonapi_errors: @ticket_desk.errors, status: :unprocessable_entity
      end
    end

    # HTTP PUT update the halls ticket_desk
    def update
      @ticket_desk = Ticket_desks::UseCases::Update.new.call(id: params[:id], params: ticket_desk_params)

      if @ticket_desk.valid?
        render jsonapi: @ticket_desk
      else
        render jsonapi_errors: @ticket_desk.errors, status: :unprocessable_entity
      end
    end

    # HTTP DELETE destroy the ticket_desk
    def destroy
      Ticket_desks::UseCases::Delete.new.call(id: params[:id])
    end

    private

    def ticket_desk_params
      params.require(:ticket_desk).permit(:online)
    end
  end
end
