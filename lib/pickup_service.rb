require 'active_support/core_ext/date_time'
require 'holidays'

class PickupService
  @@cutoff_time = "2pm"

  class << self
    def perform time
      [
        {:date=>DateTime.new(2014,9,15), :description=>"Today"},
        {:date=>DateTime.new(2014,9,16), :description=>"Tomorrow"}
      ]
    end
  end
end
