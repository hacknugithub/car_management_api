# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::CarMaintenancesController, type: :controller do
  let!(:car_maintenances) { create_list(:car_maintenance, 3) }

  describe 'GET #index' do
    it 'returns a list of all car_maintenances' do
      get :index
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end

  describe 'GET #show' do
    it 'returns the specified car_maintenance' do
      car_maintenance = car_maintenances.last
      get :show, params: { id: car_maintenance.id }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['id']).to eq(car_maintenance.id)
    end
  end

  describe 'POST #create' do
    it 'returns the created car_maintenance' do
      car = car_maintenances.last.car
      post :create,
           params: { car_maintenance: { car_id: car.id, description: 'unique description', status: :pending,
                                        date: Time.current } }
      expect(response).to have_http_status(:created)
      created_car_maintenance = car.car_maintenances.last
      expect(created_car_maintenance.description).to eq('unique description')
    end
  end

  describe 'PUT #update' do
    it 'returns the updated car_maintenance' do
      car_maintenance = car_maintenances.first
      put :update,
          params: { id: car_maintenance.id,
                    car_maintenance: { car_id: car_maintenance.car.id, description: 'unique description edited', status: :completed,
                                       date: Time.current } }
      expect(response).to have_http_status(:ok)
      car_maintenance.reload
      expect(car_maintenance.description).to eq('unique description edited')
    end
  end

  describe 'PATCH #update' do
    it 'returns the updated property on the car_maintenance' do
      car_maintenance = car_maintenances.first
      patch :update,
          params: { id: car_maintenance.id,
                    car_maintenance: { description: 'unique description edited by patch'} }
      expect(response).to have_http_status(:ok)
      car_maintenance.reload
      expect(car_maintenance.description).to eq('unique description edited by patch')
    end
  end

  describe 'GET #destroy' do
    it 'returns http success after deleting a car_maintenance' do
      car_maintenance = car_maintenances.last
      get :destroy, params: { id: car_maintenance.id }

      expect(response).to have_http_status(:success)
      expect(CarMaintenance.pluck(:id).include?(car_maintenance.id)).to be false
    end
  end
end
