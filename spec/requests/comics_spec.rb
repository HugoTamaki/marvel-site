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

  describe 'POST #favourite_comic' do
    let!(:comic) { FactoryBot.create(:comic) }

    it 'favourites one comic to current_user' do
      headers = { "ACCEPT" => "application/json" }
      post '/comics/favourite_comic.json', params: { comic: { comic_id: comic.comic_id } }, headers: headers

      user = User.first
      expect(comic).to be_in(user.comics)
    end

    it 'returns error on comic not found' do
      headers = { "ACCEPT" => "application/json" }
      post '/comics/favourite_comic.json', params: { comic: { comic_id: 121892 } }, headers: headers

      expect(response.status).to eql(400)
      expect(response.body).to eql({'message' => 'Comic not found'}.to_json)
    end

    context 'removing existing favourite' do
      before do
        headers = { "ACCEPT" => "application/json" }
        post '/comics/favourite_comic.json', params: { comic: { comic_id: comic.comic_id } }, headers: headers
      end

      it 'removes favourite from user' do
        user = User.first
        expect(comic).to be_in(user.comics)

        headers = { "ACCEPT" => "application/json" }
        post '/comics/favourite_comic.json', params: { comic: { comic_id: comic.comic_id } }, headers: headers

        expect(user.comics).to be_empty
      end
    end
  end
end
