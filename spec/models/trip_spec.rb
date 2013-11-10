require 'spec_helper'

describe Trip do

  let(:user) {FactoryGirl.create(:user)}

  before do
    @trip = user.trips.build(title: 'A nice trip !')
  end

  subject { @trip }

  it { should respond_to :title}
  it { should respond_to :user_id}
  it { should respond_to :user}
  it { should respond_to :pins }
  its(:user) { should eq user}

  it { should be_valid }

  describe 'when user_id is not present' do
    before { @trip.user = nil }
    it { should_not be_valid }
  end

  describe 'with blank title' do
    before { @trip.title = ' ' }
    it { should_not be_valid }
  end

  describe 'with title that is too long' do
    before { @trip.title = 'a' * 101 }
    it { should_not be_valid }
  end

  describe 'pin association' do

    before { @trip.save }

    let!(:pin2) { FactoryGirl.create(:pin, trip: @trip, title: 'Second Pin', pin_type: 'attraction', start_time: 1.hour.ago) }
    let!(:pin1) { FactoryGirl.create(:pin, trip: @trip, title: 'First Pin', pin_type: 'attraction', start_time: 1.day.ago) }

    it 'should have the right pins in the right order' do
      expect(@trip.pins.to_a).to eq [pin1, pin2]
    end
  end

end
