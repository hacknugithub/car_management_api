# frozen_string_literal: true

module Api
  module V1
    class CarsController < Api::BaseController
      before_action :set_car, only: %i[show update destroy]

      def index
        @cars = Car.all
        render json: @cars, status: :ok
      end

      def show
        render json: @car, status: :ok
      end

      def create
        @car = Car.new(car_params)
        if @car.save
          render json: @car, status: :created
        else
          render json: { errors: @car.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if @car.update(car_params)
          render json: @car, status: :ok
        else
          render json: { errors: @car.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        @car.destroy
        head :no_content
      end

      private

      def set_car
        @car = Car.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Car not found' }, status: :not_found
      end

      def car_params
        params.require(:car).permit(:plate_number, :year, :model)
      end
    end
  end
end
