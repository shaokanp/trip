require 'spec_helper'

describe "User Home Page" do

  subject { page }

  describe "Trip List" do

    let(:user) { FactoryGirl.create(:user) }
    before { sign_in user }


    it { should  }


  end
end
