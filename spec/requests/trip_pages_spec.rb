require 'spec_helper'

describe 'TripPage', :js => true do
  self.use_transactional_fixtures = false
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  let(:other_user) { FactoryGirl.create(:user) }
  let!(:trip) { FactoryGirl.create(:trip, user: user, title: 'Trip') }
  let!(:pin1) { FactoryGirl.create(:pin, trip: trip, title: 'Pin1', pin_type: 'attraction', start_time: 1.hour.ago, address: 'Statue of Liberty', day: 1) }
  let!(:pin2) { FactoryGirl.create(:pin, trip: trip, title: 'Pin2', pin_type: 'attraction', start_time: 1.day.ago, address: 'Lincoln Center', day: 1) }
  let!(:pin3) { FactoryGirl.create(:pin, trip: trip, title: 'Pin3', pin_type: 'attraction', start_time: 1.day.ago, address: 'Lincoln Center', day: 2) }

  before do
    sign_in user
    visit root_path
    find('#trips-container').first('.trip-digest').click
  end

  describe 'in the page' do

    describe 'show a trip detail view' do

      describe 'other user enter this trip' do

        describe 'if the trip is public' do
          it 'should show the trip' do
            trip.is_public = true
            expect(page).to have_selector('#map')
          end
        end

        describe 'if the trip is not public' do
          it 'should not show the trip' do
            trip.is_public = false
            #expect(response).to redirect_to(forbidden_path)
          end
        end

      end

      it 'should have a map' do
        expect(page).to have_selector('#map')
      end

      describe 'the left panel' do
        it 'should have a button to create pin' do
          expect(page).to have_selector('.new-pin-btn')
        end

        describe 'day navigator' do

          it 'should contain pins of correct day' do
            expect(page).to have_content(pin1.title)
            expect(page).to have_content(pin2.title)
          end

          it 'should not contain pins of different days' do
            expect(page).not_to have_content(pin3.title)
          end
        end
      end


    end

    describe 'create new pin' do

      before do
        find('#new-pin-btn-container').first('.new-pin-btn').click
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
        expect(page).not_to have_content(pin1.title)
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
