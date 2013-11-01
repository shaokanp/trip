require 'spec_helper'
#require 'watir-webdriver/extensions/alerts'

describe "User Dashboard Page" do

  subject { page }

  describe "Trip List" do

    let(:user) { FactoryGirl.create(:user) }
    let!(:trip1) { FactoryGirl.create(:trip, user: user, title: 'Foo') }
    let!(:trip2) { FactoryGirl.create(:trip, user: user, title: 'Bar') }

    before do
      sign_in user
      visit root_path
    end

    describe 'Show create trip button' do
      it { should  have_selector('#new-trip-btn') }
    end

    describe 'Show all trips belong to this user', :js => true do
      self.use_transactional_fixtures = false
      it { should have_content(trip1.title) }
      it { should have_content(trip2.title) }
    end

    describe 'Create a trip', :js => true do
      self.use_transactional_fixtures = false
      before do
        find_by_id('new-trip-btn').click
        fill_in 'title', with: 'A Wonderful Trip'
      end
      it { expect { find_by_id('submit-new-trip-btn').click }.to change(Trip, :count).by(1) }

      it 'should display the new trip in dashboard page after create a new trip' do
        find_by_id('submit-new-trip-btn').click
        expect(page).to have_content('A Wonderful Trip')
      end
    end

    describe 'Enter a trip', :js => true do
      self.use_transactional_fixtures = false
      before do
        find('#trips-container').first('.trip-digest').click
      end

      specify { expect(response).to redirect_to(trip1) }
    end

    describe 'Delete a trip', :js => true do
      self.use_transactional_fixtures = false
      before do
        find('#trips-container').first('.trip-digest').hover
      end

      it do
        find('.trip-digest .destroy').click
        expect(page).not_to have_content(trip1.title)
      end
    end

  end
end
