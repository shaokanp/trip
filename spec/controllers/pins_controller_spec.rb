require 'spec_helper'

describe PinsController do
  describe 'GET #show' do
    it 'assign the requested pin to @pin' do
      before do
        @pin = create(:pin)
        user = @pin.trip.user
        sign_in user
      end
      get :show, id: @pin
      expect(assigns(:pin)).to eq @pin
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