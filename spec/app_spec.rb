require 'spec_helper'

RSpec.describe DiscoverExoplanet do
  
  def app
    DiscoverExoplanet
  end

  before do
    allow(File).to receive(:exists?).and_return(true)
    allow(File).to receive(:read).and_return('')
  end

  context "Root url" do
    it "returns main page" do
      get '/'

      expect(last_response).to be_ok
    end
  end

  context "Other than Root url" do
    it "should render 404 status" do
      get '/something'

      expect(last_response.status).to eq(404)
      expect(last_response.body).to include('Oops. check your url!')
    end
  end
end
