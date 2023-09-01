require 'sinatra/activerecord'
require_relative '../../models/init.rb'

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
      it 'should be invalid' do
        u = User.new(name: 'John', pass: 'Hola1')
        expect(u.valid?).to be_truthy
      end
    end
  end
end