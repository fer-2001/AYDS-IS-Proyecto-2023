require 'sinatra/activerecord'
require_relative '../../models/response.rb'

describe Response do
  describe 'valid' do
    
    it 'belongs_to user' do
            association = described_class.reflect_on_association(:user)
            expect(association.macro).to eq(:belongs_to)
    end
    it 'belongs_to option' do
            association = described_class.reflect_on_association(:option)
            expect(association.macro).to eq(:belongs_to)
    end
  end
end