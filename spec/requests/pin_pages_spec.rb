require 'spec_helper'

describe 'PinPage', :js => true do
  self.use_transactional_fixtures = false
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  let(:other_user) { FactoryGirl.create(:user) }
  let!(:trip) { FactoryGirl.create(:trip, user: user, title: 'Trip') }
  let!(:pin1) { FactoryGirl.create(:pin, trip: trip, title: 'Pin1', pin_type: 'attraction', start_time: 1.hour.ago, address: 'Statue of Liberty') }
  let!(:note1) {FactoryGirl.create(:note, pin: pin1, content: 'Note number 1', image: '')}
  let!(:note1) {FactoryGirl.create(:note, pin: pin1, content: 'Note number 2', image: '')}

  before do
    sign_in user
    visit root_path
    find('#trips-container').first('.trip-digest').click
    find('#pin-container').first('.pin-cell').click
  end

  describe 'in the page' do

    describe 'the pin detail view' do
      it 'should show the pin detail view' do
        expect(page).to have_selector('#pin-info-container')
      end

      it 'should show the pin details correctly'
    end

    describe 'note list view' do
      it 'should show add note button' do
        expect(page).to have_selector('#add-new-note-btn')
      end

      it 'should display note list correctly' do
        expect(page).to have_content('Note number 1')
        expect(page).to have_content('Note number 2')
      end

      it 'should add new note correctly' do
        find('#add-new-note-btn').click
        fill_in 'content', with: 'A new note'
        find_by_id('submit-new-note-btn').click
        expect(page).to have_content('A new note')
      end

      it 'should update note correctly'
      it 'should delete note correctly'
    end
  end


end