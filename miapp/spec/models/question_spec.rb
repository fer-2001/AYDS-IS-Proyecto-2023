require 'sinatra/activerecord'
require_relative '../../models/question.rb'
require_relative '../../models/option.rb'
require_relative '../../models/user.rb'

describe 'Question' do 
    describe 'valid' do
        it 'should be invalid if question is missing' do
          q = Question.new(difficult: 1, cantPoints: 10, curiosities: 'Some curiosity')
          expect(q.valid?).to be_falsey
        end
      
        it 'should be invalid if difficult is missing' do
          q = Question.new(question: 'Some question', cantPoints: 10, curiosities: 'Some curiosity')
          expect(q.valid?).to be_falsey
        end
      
        it 'should be invalid if cantPoints is missing' do
          q = Question.new(question: 'Some question', difficult: 1, curiosities: 'Some curiosity')
          expect(q.valid?).to be_falsey
        end
      
        it 'should be invalid if curiosities is missing' do
          q = Question.new(question: 'Some question', difficult: 1, cantPoints: 10)
          expect(q.valid?).to be_falsey
        end
      
        it 'should be valid with all required attributes' do
          q = Question.new(
            question: 'Some question',
            difficult: 1,
            cantPoints: 10,
            curiosities: 'Some curiosity'
          )
          expect(q.valid?).to be_truthy
        end

        it 'should be invalid if question is empty' do
            q = Question.new
            expect(q.valid?).to be_falsey
        end

        it 'should be invalid if options size is 0' do 
            q = Question.new 
            expect(q.options.size).to eq(0)
        end
    end
end