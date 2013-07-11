require 'spec_helper'

describe CheckInController do

  describe "GET 'welcomeback'" do
    it "returns http success" do
      get 'welcomeback'
      response.should be_success
    end
  end

end
