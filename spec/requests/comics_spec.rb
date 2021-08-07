require 'rails_helper'

describe 'Comics', :type => :request do

  describe 'GET #index' do
    let!(:comic_without_character) { FactoryBot.create(:comic) }
    let!(:wolverine) { FactoryBot.create(:character, name: 'Wolverine') }
    let!(:wonder_woman) { FactoryBot.create(:character, name: 'Wonder Woman') }
    let!(:comic_with_wolverine) { FactoryBot.create(:comic, title: 'Wolverine comic') }
    let!(:comic_with_wonder_woman) { FactoryBot.create(:comic, title: 'Wonder Woman comic') }
    let!(:character_comic_wolverine) { FactoryBot.create(:character_comic, comic: comic_with_wolverine, character: wolverine) }
    let!(:character_comic_wonder_woman) { FactoryBot.create(:character_comic, comic: comic_with_wonder_woman, character: wonder_woman) }

    context 'without params' do
      before do
        get '/comics'
      end

      it 'returns http success' do
        expect(response).to have_http_status(200)
      end

      it 'returns template with comic' do
        expect(response.body).to match('My comic')
      end
    end

    context 'with search params' do
      before do
        comic_without_character
        wolverine
        wonder_woman
        comic_with_wolverine
        comic_with_wonder_woman
        character_comic_wolverine
        character_comic_wonder_woman
      end

      it 'returns wolverine comics when searching' do
        get '/comics?search=Wolverine'
        expect(response.body).to match('Wolverine')
        expect(response.body).not_to match('My Comic')
        expect(response.body).not_to match('Wonder Woman')
      end

      it 'returns wonder woman comics when searching' do
        get '/comics?search=Wonder Woman'
        expect(response.body).to match('Wonder Woman')
        expect(response.body).not_to match('My Comic')
        expect(response.body).not_to match('Wolverine')
      end
    end

  end
end
