require_relative '../../lib/pickup_service.rb'

describe PickupService do
  describe '#get_holydays' do
    it 'returns an array with britains non working days, for the current year' do
      expect( PickupService.get_holydays ).to include( Date.new( DateTime.now.year, 12,25 ) )
    end
  end

  context 'it is Monday the 15th of September at 11am' do
    before{
      allow(DateTime).to receive_messages(now: DateTime.new(2014,9,15,11))
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
      allow(DateTime).to receive_messages(now: DateTime.new(2014,9,15,15))
    }

    it 'returns the next two available days' do
      expect( PickupService.perform("2pm") ).to eq( [
        {:date=>DateTime.new(2014,9,16), :description=>"Tomorrow"},
        {:date=>DateTime.new(2014,9,17), :description=>"Wednesday"}
    ])
    end
  end

  context 'it is Friday, the 22nd of August at 4pm (and the 25th is a Bank Holiday in England)' do
    before{
      allow(DateTime).to receive_messages(now: DateTime.new(2014,8,22,16))
    }

    it 'returns the next two available days' do
      expect( PickupService.perform("4pm") ).to eq( [
        {:date=>DateTime.new(2014,8,26), :description=>"Tuesday"},
        {:date=>DateTime.new(2014,8,27), :description=>"Wednesday"}
      ])
    end
  end
end
