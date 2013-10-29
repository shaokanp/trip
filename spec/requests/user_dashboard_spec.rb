require 'spec_helper'

describe "User Dashboard Page" do

  subject { page }

  describe "Trip List" do

    let(:user) { FactoryGirl.create(:user) }
    let!(:trip1) { FactoryGirl.create(:trip, user: user, title: "Foo") }
    let!(:trip2) { FactoryGirl.create(:trip, user: user, title: "Bar") }
    before do
      sign_in user
      visit root_path
    end

    describe "Show create trip button" do
      it { should  have_selector('#newTripBtn') }
    end


    describe "Get trips" do
      it { should have_content(trip1.title) }
      it { should have_content(trip2.title) }
    end

    describe "Create a trip" do
      before do
        find_by_id('newTripBtn').click
        fill_in 'Title', with: 'A Wonderful Trip'
      end
      it { expect { find_by_id('create-trip-btn').click }.to change(Trip, :count).by(1) }

      it 'should display the new trip in dashboard page after create a new trip' do
        find_by_id('create-trip-btn').click
        expect(page).to have_content('A Wonderful Trip')
      end
    end

    describe "Enter a trip" do
      before do
        find('.tripCell').first.click
      end

      specify { expect(response).to redirect_to(trip_url) }
    end

    describe "Delete a trip" do
      before do
        find('.tripCell').first.hover
      end

      it { expect{  find('.tripCell .deleteBtn').click }.to change(Trip, :count).by(-1) }
    end

  end
end
