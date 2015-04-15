# Public Holidays

> Note: Project is in early development and the API is likely to change.

A gem that provides helper functionality for working with dates in which public holidays are a concern.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'public_holidays' :git => "git://github.com/adambutler/public_holidays.git", :branch => "master"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install public_holidays

## Usage

Configure -

```ruby
PublicHolidays.configure do |config|
  config.iso_3166_1 = "gb"
end
```

Get the next holiday from today -

```ruby
PublicHolidays.next
# => #<Date: 2016-01-01 ...>
```

Get the next working day from today -

```ruby
PublicHolidays.next_working_day
# => #<Date: 2016-01-01 ...>
```

Get the next working day from a specific date -

```ruby
from_date = Date.parse("2016/12/26")
PublicHolidays.next_working_day(from_date)
# => #<Date: 2016-01-28 ...>
```

## Contributing

1. Fork it ( https://github.com/adambutler/public_holidays/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
