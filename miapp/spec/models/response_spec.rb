require 'sinatra/activerecord'
require_relative '../../models/response.rb'

describe Response do
  describe 'valid' do
    describe 'when there is no option' do
      it 'should be valid' do
        r = Response.new
        expect(r.valid?).to be_truthy
      end
    end
  end
end