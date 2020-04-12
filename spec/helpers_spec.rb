require 'spec_helper'

include Discover::Exoplanet::Helpers

RSpec.describe "Helpers" do

  def app
    DiscoverExoplanet
  end

  let(:fake_source_path) { './spec/fixtures/fake_source.json' }
  let(:chart_data) { [{"data"=>{2010=>1}, "name"=>"Small"}, {"data"=>{2011=>1}, "name"=>"Medium"}, {"data"=>{2012=>1}, "name"=>"Large"}] }
  let(:orphan_planets_count) { 1 }
  let(:planet_orbiting_hottest_star) { 'PLANET-3' }

  before do
    @raw_data = JSON.parse(File.open(fake_source_path, 'rb').read)
  end

  describe '.discover_exoplanet' do
    it 'should return chart data for small, medium and large planets' do
      expect(discover_exoplanet).to eq(chart_data)
    end
  end

  describe '.get_no_of_orphan_planets' do
    it 'should return no. of planets having "TypeFlag" value as 3' do
      expect(get_no_of_orphan_planets).to eq(orphan_planets_count)
    end
  end

  describe '.get_planet_orbiting_hottest_star' do
    it 'should return planet identifier having highest "HostStarTempK" value' do
      expect(get_planet_orbiting_hottest_star).to eq(planet_orbiting_hottest_star)
    end
  end

  describe '.small_planets' do
    it 'should return array of small planets' do
      expect(small_planets).to eq([@raw_data[0]])
    end
  end

  describe '.medium_planets' do
    it 'should return array of medium planets' do
      expect(medium_planets).to eq([@raw_data[1]])
    end
  end

  describe '.large_planets' do
    it 'should return array of large planets' do
      expect(large_planets).to eq([@raw_data[2]])
    end
  end

  describe '.small_planets_data' do
    it 'should return small planets data' do
      expect(small_planets_data).to eq({2010=>1})
    end
  end

  describe '.medium_planets_data' do
    it 'should return medium planets data' do
      expect(medium_planets_data).to eq({2011=>1})
    end
  end

  describe '.large_planets_data' do
    it 'should return large planets data' do
      expect(large_planets_data).to eq({2012=>1})
    end
  end

  describe '.get_exoplanet_data' do
    context 'when local copy of source does not exist' do
      it 'should request source url for data' do
        allow(File).to receive(:exists?).with(LOCAL_SOURCE_JSON_FILE).and_return(false)
        get_exoplanet_data
        expect(WebMock).to have_requested(:get, SOURCE_URL).once
      end
    end

    context 'when local copy of source exists' do
      it 'should not make request to source' do
        allow(File).to receive(:exists?).with(LOCAL_SOURCE_JSON_FILE).and_return(true)
        get_exoplanet_data
        expect(WebMock).not_to have_requested(:get, SOURCE_URL).once
      end
    end
  end

  describe '.download_source' do
    it "should request source url for data" do
      download_source
      expect(WebMock).to have_requested(:get, SOURCE_URL).once
    end
  end

end
