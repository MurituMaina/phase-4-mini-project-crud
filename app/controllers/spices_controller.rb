class SpicesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_response_not_found

  def index
    spices = Spice.all
    render json: spices
  end

  def show
    spice = Spice.find(params[:id])
    render json: spice
  end

  def update
    spice = Spice.find(params[:id])
    if spice
      spice.update(spice_params)
      render json: spice
    else
      render json: { error: "Spice not found" }, status: :not_found
    end
  end

  def create
    spice = Spice.create!(spice_params)

    render json: spice, status: :created
  end

  def destroy
    spice = Spice.find(params[:id])
    spice.destroy
    head :no_content
  end

  private

  def spice_params
    params.permit(:title, :image, :description, :notes, :rating)
  end

  def render_response_not_found
    render json: { error: "Not Found" }, status: :not_found
  end
end
