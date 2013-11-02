require 'spec_helper'

describe PinsController do

  #let(:user) { FactoryGirl.create(:user) }
  #let!(:trip) { FactoryGirl.create(:trip, user: user, title: 'trip') }

  #before { sign_in user }

  describe 'GET #show' do
    it 'assign the requested pin to @pin' do

      #@pin = FactoryGirl.create(:pin, trip: trip, title: 'trip')

      #get :show, id: @pin
      #expect(assigns(:pin)).to eq @pin
    end
    it 'renders the show template'
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves the new pin in the database'
    end
    context 'with invalid attributes' do
      it 'does not save the new pin in the database'
    end
  end

  describe 'PUT #update' do
    context 'with valid attributes' do
      it 'updates the pin in the database'
    end
    context 'with invalid attributes' do
      it 'does not update the pin in the database'
    end
  end
end