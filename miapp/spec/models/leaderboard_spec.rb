require 'sinatra/activerecord'
require_relative '../../models/user.rb'
require_relative '../../models/leaderboard.rb'


RSpec.describe Leaderboard do
    it 'belong_to leaderboard_user' do 
        association = described_class.reflect_on_association(:user)
        expect(association.macro).to eq(:belongs_to) 
    end
    it 'is not valid empty leaderboard' do 
        lb = Leaderboard.new
        expect(lb.valid?).to eq(false) 
    end 

    it "should relate to a user" do
        user = User.create(name: 'Ejemplo',password: 'M3')  
        leaderboard = Leaderboard.create(rank: 1, user: user)
        expect(leaderboard.user).to eq(user)
    end


    it 'should place the user with the most points in the first position of the rank' do 
        u1 = User.create(name:'Mario',password: 'M3',points: 15)
        u2 = User.create(name:'Jose',password: 'M2',points: 5)
        Leaderboard.update_rank
        first_place = Leaderboard.first
        expect(first_place.user.name).to eq(u1.name) 
    end
end

