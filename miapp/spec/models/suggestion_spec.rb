require 'sinatra/activerecord'
require_relative '../../models/suggestion.rb'

describe 'Suggestion' do
    it 'is valid with a description' do
        sugg = Suggestion.new(description: 'Soy una sugerencia')
        expect(sugg).to be_valid
    end
    it 'is invalid without a description' do
        sugg  = Suggestion.new(description: nil)
        sugg.valid?
        expect(sugg.errors[:description]).to include("can't be blank")
    end
end