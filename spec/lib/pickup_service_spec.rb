require_relative '../../lib/pickup_service.rb'

describe PickupService do
  context 'it is Monday the 15th of September at 11am' do
    before{
      DateTime.stub(:now) {DateTime.new(2014,9,15,11)}
    }

    it 'returns the next two available days' do
      expect( PickupService.perform("2pm") ).to eq( [
        {:date=>DateTime.new(2014,9,15), :description=>"Today"},
        {:date=>DateTime.new(2014,9,16), :description=>"Tomorrow"}
      ] )
    end
  end

  context 'is Monday the 15th of September at 3pm' do
    before{
      DateTime.stub(:now) {DateTime.new(2014,9,15,15)}
    }

    it 'returns the next two available days' do
      expect( PickupService.perform("2pm") ).to eq( [
        {:date=>DateTime.new(2014,9,16), :description=>"Tomorrow"},
        {:date=>DateTime.new(2014,9,15), :description=>"Wednesday"}
    ])
    end
  end

  context 'it is Friday, the 22nd of August at 4pm (and the 25th is a Bank Holiday in England)' do
    before{
      DateTime.stub(:now) {DateTime.new(2014,9,22,16)}
    }

    it 'returns the next two available days' do
      expect( PickupService.perform("4pm") ).to eq( [
        {:date=>DateTime.new(2014,8,26), :description=>"Tuesday"},
        {:date=>DateTime.new(2014,8,27), :description=>"Wednesday"}
      ])
    end
  end
end
