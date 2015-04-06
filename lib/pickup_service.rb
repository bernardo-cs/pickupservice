require_relative 'english_date'
require 'holidays'

class PickupService
  class << self
    def perform cut_off
      get_next_working_days(2,cut_off).map{ |e| EnglishDate.new( e ).formated }
    end

    def get_next_working_days number_days, cut_off
      result = []
      current_day = DateTime.now

      current_day = current_day + 1 if is_after_cut_off?( current_day, cut_off )

      loop do
        break if result.size == number_days
        result << current_day if is_valid_for_destribution?( current_day )
        current_day = (current_day + 1 )
      end

      result
    end

    def get_holydays
      build_holydays
    end

    private
    def is_valid_for_destribution? day
      not (is_weekend?( day ) || is_holyday?( day ) )
    end

    def is_weekend? day
      day.wday == 0 || day.wday == 6
    end

    def is_holyday? day
      get_holydays.include? day.to_date
    end

    def is_after_cut_off? day, cut_off
      cut_off_int = DateTime.parse(cut_off).hour
      day.hour >= cut_off_int
    end

    def build_holydays
      from = Date.new(DateTime.now.year,1,1)
      to = Date.new(DateTime.now.year,12,31)

      Holidays.between( from, to, :gb_eng  ).map{ |e| e[:date] }
    end
  end
end
