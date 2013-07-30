# currency_parser

## Installation

Add this line to your Rails 3.x application's Gemfile:

```
gem 'currency_parser'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install CorePlugin
```

## API Summary

`CurrencyParser` works in any Ruby class, it does not require Active
Record or other ORM.  Its default settings has it configured for the
German currency format, without allowing negative values.

```
parser = CurrencyParser::Parser.new
=> #<CurrencyParser::Parser:0x007feca487fe68
 @allow_negative=false,
 @delimiter=".",
 @format=:de,
 @separator=",">

parser.to_us("1,23")
=> "1.23"

parser.to_us("-1,23")
=> "1.23"
```

The same can be achieved without any change to the default configuration
via

```
CurrencyParser::Parser.to_us("1,23")
=> "1.23"
```

As of v0.1.2 only the **`:de`** format is supported and you can allow
negative values as follows

```
parser = CurrencyParser::Parser.new(:de, :allow_negative => true)
=> #<CurrencyParser::Parser:0x007feca9f999d8
 @allow_negative=true,
 @delimiter=".",
 @format=:de,
 @separator=",">

parser.to_us("-1,23")
=> "-1.23"
```

## License

This project rocks and uses MIT-LICENSE.
