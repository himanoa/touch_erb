# TouchErb

Create from a template file command.

Received the inspiration of [touch-alt](https://github.com/akameco/touch-alt)

## Installation

```
$ gem install touch_erb
```

## Usage

```
$ ls ~/.touch_erb
today.erb

$ cat ~/.touch_erb/today.erb
<% require 'time' %>
<%= Time.new.to_s %>

$ touch_erb today
$ cat today
2019-02-15 05:13:56 +0900

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/touch_erb.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
