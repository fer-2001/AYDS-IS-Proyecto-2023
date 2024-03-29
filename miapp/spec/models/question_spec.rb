# frozen_string_literal: true

require 'sinatra/activerecord'
require_relative '../../models/question'
require_relative '../../models/option'
require_relative '../../models/user'

describe Question do
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

    it 'has_many_options' do
      association = described_class.reflect_on_association(:options)
      expect(association.macro).to eq(:has_many)
    end

    it 'has_and_belongs_to_many' do
      association = described_class.reflect_on_association(:users)
      expect(association.macro).to eq(:has_and_belongs_to_many)
    end
  end
end
