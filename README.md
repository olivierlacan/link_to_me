# LinkToMe

Extend Rails Action View's `link_to` to allow it to autolink any
Active Record model instances with a GET url.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'link_to_me'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install link_to_me

## Usage

```ruby
link_to @model
```

Will result in the following code:

```html
<a href="/models/1">Model 1</a>
```

Given the `@model` instance defines the following method:

```ruby
class Model
  def to_s
    "Model #{id}"
  end
end
```

Here, `to_s` can point to an attribute like `name` as well if it exists
and use a fallback:

```ruby
class Model
  def to_s
    name || "Model #{id}"
  end
end
```

If you don't implement a `to_s` method, `link_to` will instead default
to the original Ruby definition of `to_s` which prints the name of the
instance's class and its `object_id` in hexacidemal format:

```ruby
Object.new.to_s
=> "#<Object:0x00007fc122ad4d10>"
```

It's not quite as useful. Defining `to_s` on Rails Active Record model
classes is not at all destructive. You can still obtain the
non-hexadecimal memory object ID via `Object.new.object_id`:

```ruby
Object.new.object_id
=> 109720
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/olivierlacan/link_to_me. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/olivierlacan/link_to_me/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the LinkToMe project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/olivierlacan/link_to_me/blob/master/CODE_OF_CONDUCT.md).
