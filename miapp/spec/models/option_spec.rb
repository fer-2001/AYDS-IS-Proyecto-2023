require 'sinatra/activerecord'
require_relative '../../models/option.rb'
require_relative '../../models/question.rb'
require_relative '../../models/user.rb'


describe Option do
    it 'has_many option_responses' do
        association = described_class.reflect_on_association(:responses)
        expect(association.macro).to eq(:has_many)
    end

    it 'has_many option_user' do
        association = described_class.reflect_on_association(:users)
        expect(association.macro).to eq(:has_many)
    end
    
    
    it 'belong_to option_questions' do 
      association = described_class.reflect_on_association(:question)
      expect(association.macro).to eq(:belongs_to) 
    end

   
    it 'is not valid empty option' do 
      op = Option.new
      expect(op.valid?).to eq(false) 
    end

    it 'is valid option when there is a content and correct value' do 
      op = Option.new(content: 'opcion' , correct: true)
      expect(op.valid?).to eq(true)
    end

    it 'is invalid whithout content' do 
      op = Option.new(content: nil , correct: true) 
      expect(op.valid?).to eq(false)
    end

    it 'is invalid whithout correct' do 
      op = Option.new(content: 'si', correct: nil) 
      expect(op.valid?).to eq(false) 
    end 
  
end
    


