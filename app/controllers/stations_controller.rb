class StationsController < ApplicationController

  def index
    render json: Station.all
  end

  def show
    render json: Station.find(params[:id]).to_json(:include => :entries)
  end
end
