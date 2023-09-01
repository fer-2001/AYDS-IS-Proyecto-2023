require 'sinatra/activerecord'
require_relative '../../models/progress.rb'
require_relative '../../models/user.rb'
require_relative '../../models/option.rb'
require_relative '../../models/question.rb'

describe Progress do
    describe 'valid' do 
      before(:each) do
        @user = User.create(name: 'test_user', pass: 'Test_pass1')
      end

        describe 'when there is no current_question' do
          it 'should be valid' do
            p = Progress.new
            expect(p.valid?).to be_truthy
          end
        end

        describe 'when there is a new progress' do
          it 'should be valid' do
            p = Progress.new
                  expect(p.current_question).to eq(0)
                  expect(p.correct_answers).to eq(0)
                  expect(p.incorrect_answers).to eq(0)
                  expect(p.lose_points).to eq(0)
                  expect(p.points).to eq(0)
          end
        end

        describe 'when there is a new progress and 1 correct answer' do
          it 'should be valid' do
            q = Question.create(question: 'Pregunta', cantPoints: 10)
            o = Option.create(content: 's', correct: true, question: q)
            p = Progress.new(user: @user)
            p.update_progress(o, true)
            expect(p.correct_answers).to eq(1)
            expect(p.points).to eq(10)
          end
        end

        describe 'when there is a new progress and 1 incorrect answer' do
          it 'should be valid' do
            p = Progress.new(user: @user)
            q = Question.create(question: 'Pregunta', cantPoints: 10)
            o = Option.create(content: 's', correct: false, question: q)
            p.update_progress(o, false)
            expect(p.incorrect_answers).to eq(1)
            expect(p.lose_points).to eq(10)
          end
        end

        describe 'when there is a new progress and 1 incorrect answer and 1 correct answer' do
          it 'should be valid' do
            p = Progress.new(user: @user)
            q1 = Question.create(question: 'Pregunta1', cantPoints: 5)
            q2 = Question.create(question: 'Pregunta2', cantPoints: 10)
            o1 = Option.create(content: 's', correct: false, question: q1)
            o2 = Option.create(content: 's', correct: true, question: q2)
            p.update_progress(o1, false)
            p.update_progress(o2, true)
            expect(p.correct_answers).to eq(1)
            expect(p.incorrect_answers).to eq(1)
            expect(p.points).to eq(10)
            expect(p.lose_points).to eq(5)
          end
        end

        describe 'when there is a new progress and 2 incorrect answer' do
          it 'should be valid' do
            p = Progress.new(user: @user)
            q1 = Question.create(question: 'Pregunta1', cantPoints: 5)
            q2 = Question.create(question: 'Pregunta2', cantPoints: 10)
            o1 = Option.create(content: 's', correct: false, question: q1)
            o2 = Option.create(content: 's', correct: false, question: q2)
            p.update_progress(o1, false)
            p.update_progress(o2, false)
            expect(p.incorrect_answers).to eq(2)
            expect(p.lose_points).to eq(15)
          end
        end

        describe 'when there is a new progress and 2 correct answer' do
          it 'should be valid' do
            p = Progress.new(user: @user)
            q1 = Question.create(question: 'Pregunta1', cantPoints: 5)
            q2 = Question.create(question: 'Pregunta2', cantPoints: 10)
            o1 = Option.create(content: 's', correct: true, question: q1)
            o2 = Option.create(content: 's', correct: true, question: q2)
            p.update_progress(o1, true)
            p.update_progress(o2, true)
            expect(p.correct_answers).to eq(2)
            expect(p.points).to eq(15)
          end
        end
    end
end
