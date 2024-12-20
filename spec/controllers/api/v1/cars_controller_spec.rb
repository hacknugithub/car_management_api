# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::CarsController, type: :controller do
  let!(:cars) { create_list(:car, 3) }

  describe 'GET #index' do
    it 'returns a list of all cars' do
      get :index
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end

  describe 'GET #show' do
    it 'returns the specified car' do
      car = cars.last
      get :show, params: { id: car.id }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['id']).to eq(car.id)
    end
  end

  describe 'POST #create' do
    it 'returns the created car' do
      post :create, params: { car: { plate_number: 'YTEYT242', model: 'Camry', year: 1989 } }
      expect(response).to have_http_status(:created)
      created_car = Car.find_by(plate_number: 'YTEYT242')
      expect(created_car).to be_valid
    end
  end

  describe 'PUT #update' do
    it 'returns the updated car' do
      car = cars.last
      put :update, params: { id: car.id, car: { plate_number: 'YTEYT249', model: 'Camry turbo', year: 1990 } }
      expect(response).to have_http_status(:ok)
      car.reload
      expect(car.model).to eq('Camry turbo')
    end
  end

  describe 'PATCH #update' do
    it 'returns the updated property on a car' do
      car = cars.last
      put :update, params: { id: car.id, car: { plate_number: 'YTEYT250' } }
      expect(response).to have_http_status(:ok)
      car.reload
      expect(car.plate_number).to eq('YTEYT250')
    end
  end

  describe 'GET #destroy' do
    it 'returns http success after deleting a record' do
      car = cars.last
      get :destroy, params: { id: car.id }

      expect(response).to have_http_status(:success)
      expect(Car.pluck(:id).include?(car.id)).to be false
    end
  end
end
