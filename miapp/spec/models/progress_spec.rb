require 'sinatra/activerecord'
require_relative '../../models/progress.rb'
require_relative '../../models/user.rb'
require_relative '../../models/option.rb'


describe 'Progress' do
    describe 'valid' do 
        describe 'when there is no current_question' do
          it 'should be valid' do
            p = Progress.new
            expect(p.valid?).to be_truthy
          end
        end

        describe 'when there is a new progress, current_questiond = 0' do
          it 'should be valid' do
            p = Progress.new
            expect(p.current_question == 0).to be_truthy
          end
        end

        describe 'when there is a new progress, correct_answers = 0' do
          it 'should be valid' do
            p = Progress.new
            expect(p.correct_answers == 0).to be_truthy
          end
        end

        describe 'when there is a new progress, incorrec_answers = 0' do
          it 'should be valid' do
            p = Progress.new
            expect(p.incorrect_answers == 0).to be_truthy
          end
        end

        describe 'when there is a new progress, lose_points = 0' do
          it 'should be valid' do
            p = Progress.new
            expect(p.lose_points == 0).to be_truthy
          end
        end

        describe 'when there is a new progress, points = 0' do
          it 'should be valid' do
            p = Progress.new
            expect(p.points == 0).to be_truthy
          end
        end

        describe 'when there is a new progress and 1 correct answer' do
          it 'should be valid' do
            u = User.new
            p = Progress.new(user: u)  # Asigna el usuario a la instancia de progreso
            o = Option.create(content: 's', correct: true)
            p.check_and_update_progress(u, o)
            expect(p.correct_answers).to eq(1)
          end
        end

        describe 'when there is a new progress and 1 incorrect answer' do
          it 'should be valid' do
            u = User.new
            p = Progress.new(user: u)  # Asigna el usuario a la instancia de progreso
            o = Option.create(content: 's', correct: false)
            p.check_and_update_progress(u, o)
            expect(p.incorrect_answers).to eq(1)  # Cambiar a "incorrect_answers"
          end
        end

        describe 'when there is a new progress and 1 incorrect answer and 1 correct answer' do
          it 'should be valid' do
            u = User.new
            p = Progress.new(user: u)  # Asigna el usuario a la instancia de progreso
            o = Option.create(content: 's', correct: false)
            p.check_and_update_progress(u, o)
            o2 = Option.create(content: 's', correct: true)
            p.check_and_update_progress(u, o2)
            expect(p.correct_answers).to eq(1)  
            expect(p.incorrect_answers).to eq(1)
          end
        end

        describe 'when there is a new progress and 2 incorrect answer' do
          it 'should be valid' do
            u = User.new
            p = Progress.new(user: u)  # Asigna el usuario a la instancia de progreso
            o = Option.create(content: 's', correct: false)
            p.check_and_update_progress(u, o)
            o2 = Option.create(content: 's', correct: false)
            p.check_and_update_progress(u, o2)
            expect(p.incorrect_answers).to eq(2)
          end
        end

        describe 'when there is a new progress and 2 correct answer' do
          it 'should be valid' do
            u = User.new
            p = Progress.new(user: u)  # Asigna el usuario a la instancia de progreso
            o = Option.create(content: 's', correct: true)
            p.check_and_update_progress(u, o)
            o2 = Option.create(content: 's', correct: true)
            p.check_and_update_progress(u, o2)
            expect(p.correct_answers).to eq(2)
          end
        end
    end
end
