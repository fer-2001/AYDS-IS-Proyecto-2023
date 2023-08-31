require 'sinatra/activerecord'
require_relative '../../models/report.rb'

describe Report do
    describe 'valid' do 
        it 'should be invalid' do
            r = Report.new
            expect(r.valid?).to be_falsey
        end
        
        it 'belongs_to user' do
            association = described_class.reflect_on_association(:user)
            expect(association.macro).to eq(:belongs_to)
        end

    end
end