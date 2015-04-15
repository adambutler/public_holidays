require 'spec_helper'

RSpec.describe PublicHolidays do
  before do
    PublicHolidays.configure do |config|
      config.iso_3166_1 = "gb"
    end
  end

  context "#next" do
    it "returns the next holiday" do
      Timecop.freeze(Date.parse("2015/12/29"))
      expect(PublicHolidays.next).to eq(Date.parse("2016/01/01"))
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