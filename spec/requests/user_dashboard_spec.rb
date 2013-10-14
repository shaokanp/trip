require 'spec_helper'

describe "User Dashboard Page" do

  subject { page }

  describe "Trip List" do

    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit root_path
    end

    describe "Show create trip button" do
      it { should  have_selector('#newTripBtn') }
    end

    let!(:trip1) { FactoryGirl.create(:trip, user: user, title: "Foo") }
    let!(:trip2) { FactoryGirl.create(:trip, user: user, title: "Bar") }
    describe "Get trips" do
      it { should have_content(trip1.title) }
      it { should have_content(trip2.title) }
    end

    describe "Create a trip" do
      before do
        find('#newTripBtn').click
        fill_in "Title", with: "A Wonderful Trip"
      end
      it { expect { click_button submit }.to change(Trip, :count).by(1) }
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
