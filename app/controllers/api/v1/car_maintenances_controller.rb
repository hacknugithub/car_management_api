# frozen_string_literal: true

module Api
  module V1
    class CarMaintenancesController < ApplicationController
      before_action :set_car_maintenance, only: %i[show update destroy]

      def index
        @car_maintenances = CarMaintenance.all
        render json: @car_maintenances, status: :ok
      end

      def show
        render json: @car_maintenance, status: :ok
      end

      def create
        @car_maintenance = CarMaintenance.new(car_maintenance_params)
        if @car_maintenance.save
          render json: @car_maintenance, status: :created
        else
          render json: { errors: @car_maintenance.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if @car_maintenance.update(car_maintenance_params)
          render json: @car_maintenance, status: :ok
        else
          render json: { errors: @car_maintenance.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        @car_maintenance.destroy
        head :no_content
      end

      private

      def set_car_maintenance
        @car_maintenance = CarMaintenance.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Car Maintenance not found' }, status: :not_found
      end

      def car_maintenance_params
        params.require(:car_maintenance).permit(:car_id, :description, :status, :date)
      end
    end
  end
end
