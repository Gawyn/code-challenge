require 'google_search_artworks_parser'
require 'json'

RSpec.describe GoogleSearchArtworksParser do
  ARTWORK_PROPERTIES = %w{extensions image link name}

  describe '.parse' do
    describe 'Van Gogh example' do
      before do
        @expected_result = JSON.parse(File.read('files/expected-array.json'))
        @result = GoogleSearchArtworksParser.parse('files/van-gogh-paintings.html')
      end

      it 'returns the right amount of artworks' do
        expect(@result['artworks'].count).to eq(@expected_result['artworks'].count)
      end

      it 'returns elements with the right properties' do
        expect(@result['artworks'].first.keys.sort).to eq(ARTWORK_PROPERTIES)
      end

      ARTWORK_PROPERTIES.each do |artwork_property|
        it "returns elements with the right #{artwork_property}" do
          expected_attributes = @expected_result['artworks'].map { |artwork| artwork.fetch(artwork_property, nil) } 

          expect(@result['artworks'].map { |artwork| artwork.fetch(artwork_property, nil) }).to eq(expected_attributes)
        end
      end
    end

    describe 'Rodin example' do
      before do
        @expected_result = JSON.parse(File.read('files/rodin.json'))
        @result = GoogleSearchArtworksParser.parse('files/rodin-artworks.html')
      end

      it 'returns the right amount of artworks' do
        expect(@result['artworks'].count).to eq(@expected_result['artworks'].count)
      end

      it 'returns elements with the right properties' do
        expect(@result['artworks'].first.keys.sort).to eq(ARTWORK_PROPERTIES)
      end

      ARTWORK_PROPERTIES.each do |artwork_property|
        it "returns elements with the right #{artwork_property}" do
          expected_attributes = @expected_result['artworks'].map { |artwork| artwork.fetch(artwork_property, nil) } 

          expect(@result['artworks'].map { |artwork| artwork.fetch(artwork_property, nil) }).to eq(expected_attributes)
        end
      end
    end

    describe 'Miro example' do
      before do
        @expected_result = JSON.parse(File.read('files/miro.json'))
        @result = GoogleSearchArtworksParser.parse('files/miro-artworks.html')
      end

      it 'returns the right amount of artworks' do
        expect(@result['artworks'].count).to eq(@expected_result['artworks'].count)
      end

      it 'returns elements with the right properties' do
        expect(@result['artworks'].first.keys.sort).to eq(ARTWORK_PROPERTIES)
      end

      ARTWORK_PROPERTIES.each do |artwork_property|
        it "returns elements with the right #{artwork_property}" do
          expected_attributes = @expected_result['artworks'].map { |artwork| artwork.fetch(artwork_property, nil) } 

          expect(@result['artworks'].map { |artwork| artwork.fetch(artwork_property, nil) }).to eq(expected_attributes)
        end
      end
    end
  end
end
