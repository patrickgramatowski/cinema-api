# frozen_string_literal: true

module Api
  class MoviesController < ApplicationController
    # HTTP GET list of movies
    def index
      render jsonapi: Movies::UseCases::FetchAll.new.call
    end

    # HTTP GET movie by id
    def show
      render jsonapi: Movies::UseCases::FetchOne.new.call(id: params[:id])
    end

    # HTTP POST create movie
    def create
      @movie = Movies::UseCases::Create.new.call(params: movie_params)

      if @movie.valid?
        render jsonapi: @movie, status: :created
      else
        render jsonapi_errors: @movie.errors, status: :unprocessable_entity
      end
    end

    # HTTP PUT update the movies params
    def update
      @movie = Movies::UseCases::Update.new.call(id: params[:id], params: movie_params)

      if @movie.valid?
        render jsonapi: @movie
      else
        render jsonapi_errors: @movie.errors, status: :unprocessable_entity
      end
    end

    # HTTP DELETE destroy the movie
    def destroy
      Movies::UseCases::Delete.new.call(id: params[:id])
    end

    private

    def movie_params
      params.require(:movie).permit(:title, :genre, :length)
    end
  end
end
