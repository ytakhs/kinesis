# Kinesis
Kinesis is an implementation of [JSON Reference](https://tools.ietf.org/html/draft-pbryan-zyp-json-ref-03) and [JSON Pointer](https://tools.ietf.org/html/rfc6901) written in Ruby.

This library is assumed to use for schema of `Swagger`.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'kinesis'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kinesis

## Usage

```ruby
file = File.read(path_to_file)
schema = YAML.load(file)
Kinesis.resolve(scheme)
```

## TODO
- escape syntax for JSON Pointer
- extension for JSON Reference

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Kinesis project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/jit-y/kinesis/blob/master/CODE_OF_CONDUCT.md).
