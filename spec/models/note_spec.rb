require 'spec_helper'

describe Note do

  let(:user) { FactoryGirl.create(:user) }
  let!(:trip) { FactoryGirl.create(:trip, user: user, title: "Foo") }
  let!(:pin) { FactoryGirl.create(:pin, trip: trip, title: "A pin", pin_type: Pin::PIN_DINING) }

  before do
    @note = pin.notes.build(title: 'A note')
  end

  subject{ @note }

  it { should respond_to :content }
  it { should respond_to :pin }
  it { should respond_to :pin_id }
  its(:pin) { should eq pin }

  it { should be_valid }

  describe 'when pin_id is not present' do
    before { @note.pin = nil }
    it { should_not be_valid }
  end
end
