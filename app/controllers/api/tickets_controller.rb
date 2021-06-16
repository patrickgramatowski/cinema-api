# frozen_string_literal: true

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

    private

    def ticket_params
      params.require(:ticket).permit(:seat, :ticket_type, :price)
    end
  end
end
