require 'spec_helper'

RSpec.describe PublicHolidays do
  before do
    PublicHolidays.configure do |config|
      config.iso_3166_1 = "gb"
    end
  end

  context "#now" do
    it "returns a Date representing the time now" do
      now = Date.parse("2015/01/01")
      Timecop.freeze(now)
      expect(PublicHolidays.now.to_time.to_i).to eq(now.to_time.to_i)
    end
  end

  context "#past" do
    it "returns all past public holidays" do
      Timecop.freeze(Date.parse("2015/12/29"))
      future = PublicHolidays.past
      expect(future.size).to eq(5)
      expect(future.first).to eq(Date.parse("2015/05/04"))
      expect(future.last).to eq(Date.parse("2015/12/28"))
    end
  end

  context "#future" do
    it "returns all future public holidays" do
      Timecop.freeze(Date.parse("2015/12/29"))
      future = PublicHolidays.future
      expect(future.size).to eq(80)
      expect(future.first).to eq(Date.parse("2016/01/01"))
      expect(future.last).to eq(Date.parse("2025/12/26"))
    end
  end

  context "#next" do
    it "returns the next holiday" do
      Timecop.freeze(Date.parse("2015/12/29"))
      expect(PublicHolidays.next).to eq(Date.parse("2016/01/01"))

      from_date = Date.parse("2016/12/26")
      expect(PublicHolidays.next(from_date)).to eq(Date.parse("2016/12/27"))
    end
  end

  context "#next_working_day" do
    it "returns the next non-holiday" do
      Timecop.freeze(Date.parse("2016/12/26"))
      expect(PublicHolidays.next_working_day).to eq(Date.parse("2016/12/28"))

      Timecop.freeze(Date.parse("2016/01/01"))
      from_date = Date.parse("2016/12/26")
      expect(PublicHolidays.next_working_day(from_date)).to eq(Date.parse("2016/12/28"))
    end
  end
end
