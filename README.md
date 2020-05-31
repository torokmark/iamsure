
![Travis (.org)](https://img.shields.io/travis/torokmark/iamsure)
![Coveralls github](https://img.shields.io/coveralls/github/torokmark/iamsure)
# Iamsure

IamSure is a precondition checker by chaining conditions next one another.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'iamsure'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install iamsure

## Usage

```ruby
def fun(arg)
  IamSure.of(arg)
    .not_nil("argument cannot be null")
    .get # => arg
end
```

```ruby
class CustomUnpacker < Iamsure::Unpacker
  def unpack(arg)
    "#{ arg }/some.rb"
  end
end

class CustomInitiator < Iamsure::Initiator
  def init(arg)
    arg.to_s
  end
end

def fun(arg)
  IamSure.of(arg)
    .not_nil('arg cannot be nil!')
    .unpack(CustomUnpacker.new)
    .not_empty("arg cannot be empty")
    .exist(as: :file)
    .get(CustomInitiator.new) # => 
end
```
## Documentation

`IamSure.of(arg): IamSure` creates new instance with the given argument.

`IamSure#not_nil(msg): IamSure` check whether the value is not `nil`.

`IamSure#not_empty(msg): IamSure` check whether the value is not empty.

`IamSure#exist(as): IamSure` check whether the value is file (`as: :file`) or directory (`as: :dir`).

`IamSure#unpack(unpacker): IamSure` transforms the value into a new one.

`IamSure#get(initiator): object` returns the the checked object or its initiated value.




## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/torokmark/iamsure. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Iamsure project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/torokmark/iamsure/blob/master/CODE_OF_CONDUCT.md).
