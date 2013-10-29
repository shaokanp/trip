require 'spec_helper'

describe Pin do

  let(:user) { FactoryGirl.create(:user) }
  let!(:trip) { FactoryGirl.create(:trip, user: user, title: "Foo") }

  before do
    @pin = trip.pins.build(title: 'A Pin !')
  end

  subject{ @pin }

  it { should respond_to :title }
  it { should respond_to :trip }
  it { should respond_to :trip_id }
  it { should respond_to :start_time }
  its(:trip) { should eq trip }

  it { should be_valid }

  describe 'when trip_id is not present' do
    before { @pin.trip = nil }
    it { should_not be_valid }
  end

  describe 'with blank title' do
    before { @pin.title = ' ' }
    it { should_not be_valid }
  end

  describe 'with title that is too long' do
    before { @pin.title = 'a' * 101 }
    it { should_not be_valid }
  end

end
