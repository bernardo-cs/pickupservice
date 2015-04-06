require_relative '../../lib/english_date.rb'

describe EnglishDate do
  describe '#humanize' do
    it 'returns today if it is the current date' do
      day = EnglishDate.new(DateTime.now)
      expect( day.humanize ).to eq( 'Today' )
    end
    it 'returns tomorrow if it is the day after today' do
      day = EnglishDate.new(DateTime.now + 1)
      expect( day.humanize ).to eq( 'Tomorrow' )
    end
    it 'returns the day of the week if it is not today' do
      day = EnglishDate.new(DateTime.new(2014,8,27))
      expect( day.humanize ).to eq( 'Wednesday' )
    end
  end
  describe '#formated' do
    it 'returns a formated hash of the date' do
      day = EnglishDate.new(DateTime.new(2014,8,27))
      expect( day.formated ).to eq({ date: day.to_date , :description=>day.humanize})
    end
  end
end
