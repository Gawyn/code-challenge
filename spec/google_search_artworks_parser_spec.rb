require 'google_search_artworks_parser'
require 'json'

RSpec.describe GoogleSearchArtworksParser do
  describe '.parse' do
    it 'returns an array with the data of the artworks returned' do
      result = JSON.parse(File.read('files/expected-array.json'))
      expect(GoogleSearchArtworksParser.parse('files/van-gogh-paintings.html')).to eq(result)
    end
  end
end
