class Api::V1::ActivitiesController < ApplicationController
  skip_before_action :verify_authenticity_token, raise: false

  def index
    activities = Activity.where(active: true)
    render json: { status: "success", data: activities }, status: :ok
  end

  def show
    activity = Activity.find(params[:id])
    render json: { status: "success", data: activity }, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { status: "error", message: "Actividad no encontrada" }, status: :not_found
  end
end