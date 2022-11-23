# LinkToMe

> :warning: Guess what?! You no longer need link_to_me if you use Rails 7.0.x or newer, it was [merged in as a feature][merged] on September 21st, 2021! 
> 
> As a consequence I will no longer be maintaining this gem, but feel free to use try it in older versions of Rails but please note I haven't tested it on any version prior to Rails 7, and it therefore may not be compatible.

[merged]: https://github.com/rails/rails/pull/42234

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

Instead of having the write the oddly repetitive:

```ruby
link_to @model.name, @model
```

Or if you have a `to_s` method on `Model` already, the still silly:

```ruby
link_to @model, @model
```

You can now write:

```ruby
link_to @model
```

Which will result in the following code:

```html
<a href="/models/1">Model 1</a>
```

Given the `@model` instance's class `Model` defines the following method:

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

### How does it work?

LinkToMe uses a [Railtie](/blob/main/lib/link_to_me/railtie.rb) to hook
into the boot process for Action View and include itself inside of
[`ActionView::Helpers::UrlHelper`][urlhelper]. Using the `self.included`
hook, it aliases the existing `link_to` method to `_rails_link_to` and
then removes the `link_to` method so that its own [slightly different
`link_to`][linkto] method can take over.

The core of the logic simply checks whether the first parameter to
`link_to` (which is usually a string) responds to the `model_name`
method, which indicates that it's an Active Record model instance.
It also checks whether there are other arguments provided, which would
indicate `link_to` is being given a specific path.

This means you can still override the inferred path even if you decide
to use `link_to`'s ability (via `url_for`) to infer a given active record
model instance's name.

[urlhelper]: https://github.com/rails/rails/blob/ee7cf8cf7569ef87079c48ee81c867eae5e24ed4/actionview/lib/action_view/helpers/url_helper.rb
[linkto]: https://github.com/olivierlacan/link_to_me/blob/b0157b4df3196c4f56613e23762b19459362c7d5/lib/link_to_me.rb#L154-L164

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/olivierlacan/link_to_me. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/olivierlacan/link_to_me/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the LinkToMe project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/olivierlacan/link_to_me/blob/master/CODE_OF_CONDUCT.md).
