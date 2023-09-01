require 'sinatra/activerecord'
require_relative '../../models/init.rb'
require_relative '../../models/option.rb'
require_relative '../../models/question.rb'


describe User do
  describe 'valid' do
    describe 'when there is no name' do
      it 'should be invalid' do
        u = User.new
        expect(u.valid?).to eq(false)
      end
    end

    describe 'when there is a name and pass' do
      it 'is valid' do
        u = User.new(name: 'John', pass: 'A1')
        expect(u.valid?).to eq(true)
      end
    end

    describe 'when there is no pass' do 
      it 'should be invalid' do
        u = User.new(name: 'John', pass: nil)
        expect(u.valid?).to eq(false)
      end
    end
    
    describe 'when there is no life' do
      it 'should be invalid' do
        u = User.new(name: 'John', lifes: 2)
        expect(u.valid?).to eq(false)
      end
    end

    describe ' when there is no points' do 
      it 'should be invalid' do
        u = User.new(name: 'John', points: nil)
        expect(u.valid?).to eq(false)
      end
    end

    describe 'when there is no streack' do 
      it 'should be invaled' do
        u = User.new(name: 'John', streak: nil)
        expect(u.valid?).to be_falsey
      end
    end

    describe 'when there is no role' do 
      it 'should be invalid' do
        u = User.new(name: 'John', role: nil)
        expect(u.valid?).to be_falsey
      end
    end

    describe 'when name is blank' do 
      it 'should be invalid' do
        u = User.new(name: '', pass: 'hola')
        expect(u.valid?).to be_falsey
        expect(u.errors[:name]).to include("can't be blank")
      end
    end

    describe 'when pass not contains a capital letter' do 
        it 'should be invalid' do
          u = User.new(name: 'John', pass: 'hola1')
          expect(u.valid?).to be_falsey
          expect(u.errors[:pass]).to include("La contraseña contener al menos una letra mayúscula y un número")
      end
    end

    describe 'when pass not contains a number' do 
      it 'should be invalid' do
        u = User.new(name: 'John', pass: 'Hola')
        expect(u.valid?).to be_falsey
        expect(u.errors[:pass]).to include("La contraseña contener al menos una letra mayúscula y un número")
      end
    end

    describe 'when pass contains a number and a capital letter' do 
      it 'should be valid' do
        u = User.new(name: 'John', pass: 'Hola1')
        expect(u.valid?).to be_truthy
      end
    end

    describe 'when use the method update field and is correct' do
      it 'should be valid' do
        q = Question.create(question: 'Pregunta', cantPoints: 10)
        o = Option.create(content: 's', correct: true, question: q)
        u = User.new(name: 'John1', pass: 'Hola1')
        u.update_fields(o)
        expect(u.points).to eq(q.cantPoints) # Utilizar q directamente
        expect(u.streak).to eq(1)
      end
    end

    describe 'when use the method update field and is incorrect' do
      it 'should be valid' do
        q = Question.create(question: 'Pregunta', cantPoints: 10)
        o = Option.create(content: 's', correct: false, question: q)
        u = User.new(name: 'John2', pass: 'Hola1')
        u.update_fields(o)
        expect(u.streak).to eq(0)
        expect(u.lifes).to eq(4)
      end
    end

    describe 'when use the method update role' do
    it 'should be valid' do
      q1 = Question.create(question: 'Pregunta', cantPoints: 11)
      q2 = Question.create(question: 'Pregunta', cantPoints: 51)
      q3 = Question.create(question: 'Pregunta', cantPoints: 121)
      o1 = Option.create(content: 's', correct: true,  question: q1)
      o2 = Option.create(content: 's', correct: true,  question: q2) # Asocia la opción a una pregunta
      o3 = Option.create(content: 's', correct: true,  question: q3)
      u = User.new(name: 'John2', pass: 'Hola1')
      u.update_role
      u.update_fields(o1)
      u.update_role
      expect(u.role).to eq('Novato')
      u.update_fields(o2)
      u.update_role
      expect(u.role).to eq('Finalista')
      u.update_fields(o3)
      u.update_role
      expect(u.role).to eq('Campeon')
    end
  end
  end
end