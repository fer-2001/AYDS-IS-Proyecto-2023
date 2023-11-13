# frozen_string_literal: true

require 'sinatra/activerecord'
require_relative '../../models/init'
require_relative '../../models/option'
require_relative '../../models/question'

describe User do
  describe 'valid' do
    describe 'when there is no name' do
      it 'should be invalid' do
        u = User.new
        expect(u.valid?).to eq(false)
      end
    end

    describe 'when there is no password' do
      it 'should be invalid' do
        u = User.new(name: 'John', password: nil)
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
        u = User.new(name: '', password: 'hola')
        expect(u.valid?).to be_falsey
        expect(u.errors[:name]).to include("can't be blank")
      end
    end

    describe 'when lifes equal 0' do
      it 'should be valid' do
        u = User.new(name: 'John', password: 'Hola1', lifes: 0)
        expect(u.check_lifes).to be_truthy
      end
    end

    describe 'when use the method for buy cards' do
      it 'should be valid' do
        u = User.new(name: 'John', coins: 140)
        v = User.new(name: 'Manu', coins: 5)
        expect(v.buy_card(1)).to be_falsey
        expect(u.buy_card(1)).to be_truthy
        expect(u.buy_card(2)).to be_truthy
        expect(u.buy_card(3)).to be_truthy
        expect(u.buy_card(4)).to be_truthy
        expect(u.buy_card(5)).to be_truthy
        expect(u.buy_card(6)).to be_truthy
        expect(u.buy_card(7)).to be_truthy
        expect(u.buy_card(8)).to be_truthy
        expect(u.buy_card(9)).to be_truthy
        expect(u.buy_card(10)).to be_truthy
        expect(u.buy_card(11)).to be_truthy
        expect(u.buy_card(12)).to be_truthy
        expect(u.buy_card(13)).to be_truthy
      end
    end

    describe 'when use the method for set cards by name' do
      it 'should be valid' do
        u = User.new(name: 'John', password: 'Hola1', card: 'Messi')
        u.set_card_by_name
        expect(u.card).to eq('carta1')
        v = User.new(name: 'John', password: 'Hola1', card: 'Dibala')
        v.set_card_by_name
        expect(v.card).to eq('carta2')
        c = User.new(name: 'John', password: 'Hola1', card: 'Romero')
        c.set_card_by_name
        expect(c.card).to eq('carta3')
        x = User.new(name: 'John', password: 'Hola1', card: 'Martinez')
        x.set_card_by_name
        expect(x.card).to eq('carta4')
        z = User.new(name: 'John', password: 'Hola1', card: 'Molina')
        z.set_card_by_name
        expect(z.card).to eq('carta5')
        b = User.new(name: 'John', password: 'Hola1', card: 'Otamendi')
        b.set_card_by_name
        expect(b.card).to eq('carta6')
        n = User.new(name: 'John', password: 'Hola1', card: 'Tagliafico')
        n.set_card_by_name
        expect(n.card).to eq('carta7')
        m = User.new(name: 'John', password: 'Hola1', card: 'Fernandez')
        m.set_card_by_name
        expect(m.card).to eq('carta8')
        a = User.new(name: 'John', password: 'Hola1', card: 'De Paul')
        a.set_card_by_name
        expect(a.card).to eq('carta9')
        s = User.new(name: 'John', password: 'Hola1', card: 'Mac Allister')
        s.set_card_by_name
        expect(s.card).to eq('carta10')
        d = User.new(name: 'John', password: 'Hola1', card: 'Di Maria')
        d.set_card_by_name
        expect(d.card).to eq('carta11')
        f = User.new(name: 'John', password: 'Hola1', card: 'Alvarez')
        f.set_card_by_name
        expect(f.card).to eq('carta12')
        g = User.new(name: 'John', password: 'Hola1', card: 'Scaloni')
        g.set_card_by_name
        expect(g.card).to eq('carta13')
        g = User.new(name: 'John', password: 'Hola1', card: 's')
        g.set_card_by_name
      end
    end

    describe 'when use the method update field and is correct' do
      it 'should be valid' do
        q = Question.create(question: 'Pregunta', cantPoints: 10)
        o = Option.create(content: 's', correct: true, question: q)
        u = User.new(name: 'John1', password: 'Hola1', lifes: 4)
        u.update_fields(o)
        expect(u.points).to eq(q.cantPoints)
        expect(u.streak).to eq(1)
      end
    end

    describe 'when use the method update field and is incorrect' do
      it 'should be valid' do
        q = Question.create(question: 'Pregunta', cantPoints: 10)
        o = Option.create(content: 's', correct: false, question: q)
        u = User.new(name: 'John2', password: 'Hola1')
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
        u = User.new(name: 'John2', password: 'Hola1')
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
