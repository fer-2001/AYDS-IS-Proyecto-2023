require 'sinatra/activerecord'
require_relative '../../models/report.rb'

describe 'Report' do
    describe 'valid' do 
        describe 'when there is no description' do
            it 'should be invalid' do
                r = Report.new
                expect(r.valid?).to be_falsey
            end
        end
    end
end