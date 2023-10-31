# frozen_string_literal: true

require 'sinatra/activerecord'
require_relative '../../models/suggestion'
require_relative '../../models/user'

describe Suggestion do
  it 'is valid with a description' do
    sugg = Suggestion.new(description: 'Soy una sugerencia')
    expect(sugg).to be_valid
  end
  it 'is invalid without a description' do
    sugg = Suggestion.new(description: nil)
    sugg.valid?
    expect(sugg.errors[:description]).to include("can't be blank")
  end

  it 'belong_to suggestion_users' do
    association = described_class.reflect_on_association(:user)
    expect(association.macro).to eq(:belongs_to)
  end
end
