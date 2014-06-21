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
$ gem install currency_parser
```

## API Summary

`CurrencyParser` works in any Ruby class, it does not require Active
Record or other ORM.  Its default settings has it configured for the
German currency format, without allowing negative values.

```
parser = CurrencyParser::Parser.new
=> #<CurrencyParser::Parser:0x007feca487fe68
 @allow_negative=false,
 @format=:de,

parser.to_us("1,23")
=> "1.23"

parser.to_us("-1,23")
=> "1.23"
```

The same can be achieved without any change to the default configuration
via

```
CurrencyParser::Parser.to_us("1,23", :de, false)
=> "1.23"
```

As of v0.1.2 only the **`:de`** format is supported and you can allow
negative values as follows

Supported format: **`:de`** **`:us`** **`:pl`**

You can convert to that format from any format supplying delimeter and separator, and optionally allow negative values:

```
parser = CurrencyParser::Parser.new(:fr, :separator => ',', :delimeter => ' ' :allow_negative => true)
=> #<CurrencyParser::Parser:0x007feca9f999d8
 @allow_negative=true,
 @format=:fr,

parser.to_de("-1 000,23")
=> "-1.000,23"
```

Invalid formats will raise an `InvalidFormatError` exception.


## License

This project rocks and uses MIT-LICENSE.
