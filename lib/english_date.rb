require 'active_support/all'
require 'forwardable'

class EnglishDate
  attr_accessor :date

  extend Forwardable
  def_delegators :@date, :to_date, :wday

  def initialize date
    @date = date
  end

  def humanize
    case date.strftime("%A")
    when DateTime.now.strftime("%A")
      'Today'
    when ( DateTime.now + 1 ).strftime("%A")
      'Tomorrow'
    else
      date.strftime("%A")
    end
  end

  def formated
    { date: to_date, description: humanize }
  end
end
