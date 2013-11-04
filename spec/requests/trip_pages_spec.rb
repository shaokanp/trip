require 'spec_helper'

describe 'TripPage', :js => true do
  self.use_transactional_fixtures = false
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  let(:other_user) { FactoryGirl.create(:user) }
  let!(:trip) { FactoryGirl.create(:trip, user: user, title: 'Trip') }
  let!(:pin1) { FactoryGirl.create(:pin, trip: trip, title: 'Pin1', start_time: 1.hour.ago, address: 'Statue of Liberty') }
  let!(:pin2) { FactoryGirl.create(:pin, trip: trip, title: 'Pin2', start_time: 1.day.ago, address: 'Lincoln Center') }

  before do
    sign_in user
    visit root_path
    find('#trips-container').first('.trip-digest').click
  end

  describe 'in the page' do

    describe 'show a trip detail view' do

      it 'should have a map' do
        expect(page).to have_selector('#map')
      end

      it 'should have a button to create pin' do
        expect(page).to have_selector('.new-pin-btn')
      end

    end

    describe 'create new pin' do

      before do
        find('#new-pin-btn-container').first('.new-pin-btn a').click
      end

      it 'should have pin info form popup' do
        expect(page).to have_selector('#pin-info-form')
      end

      it 'after fill in and submit the form' do
        fill_in 'title', with: 'Visit MOMA'
        fill_in 'address', with: '11 W 53rd St New York, NY 10019'
        find_by_id('submit-new-pin-btn').click
        expect(page).to have_content('Visit MOMA')
      end

    end

    describe 'delete a pin' do

      it 'should delete pin correctly' do
        find('#pin-container').first('.pin-cell .destroy').click
        expect(page).not_to have_content(pin2.title)
      end

    end

    describe 'another user' do

      before do
        sign_in other_user
        visit trip_path(trip)
      end

      it 'should see the 2 pins' do
        expect(page).to have_content(pin1.title)
        expect(page).to have_content(pin2.title)
      end

      it 'should not have the permission to delete trip' do
        find('#pin-container').first('.pin-cell .destroy').click
        expect(page).to have_content(pin2.title)
      end

    end

  end



end
