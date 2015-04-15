require "public_holidays/version"
require "yaml"

module PublicHolidays
  class << self
    attr_accessor :configuration
  end

  class Date < Date
    def is_holiday?
      PublicHolidays.configuration.holidays.include? self
    end
  end

  def self.now
    Date.today
  end

  def self.past
    configuration.holidays.select do |holiday|
      holiday < now
    end
  end

  def self.future
    configuration.holidays.select do |holiday|
      holiday > now
    end
  end

  def self.next
    future.first
  end

  def self.next_working_day(from_date = Date.today)
    # Ensure that the from_date is a PublicHolidays::Date instead of a Date
    from_date = Date.parse(from_date.to_s)

    # Loops dates until a non-holiday date is found
    days = 1
    loop do
      date = from_date + days
      if date.is_holiday?
        days += 1
      else
        break date
      end
    end
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :iso_3166_1
    attr_accessor :holidays

    def initialize
      @iso_3166_1 = "gb"
      holidays_yml = YAML.load_file("#{File.expand_path("../..", __FILE__)}/db/#{iso_3166_1}.yml")

      @holidays = holidays_yml.map do |holiday|
        Date.parse(holiday)
      end
    end
  end
end
