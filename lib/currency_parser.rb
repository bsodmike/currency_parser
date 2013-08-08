# encoding: utf-8

module CurrencyParser
  autoload :Errors, 'currency_parser/errors'

  class Parser

    # Defaults:
    # * :format - The default format is `:de`
    # * :separator - The character to use after the integer part, default is ','
    # * :delimiter - The character to use between every 3 digits of the integer part, default '.'
    def initialize(format = :de, *args)
      # NOTE defaults
      set_format(@format = format)
      @allow_negative = false

      opt = args.last.is_a?(Hash) ? args.pop : {}
      @allow_negative = opt[:allow_negative] if opt[:allow_negative] && (opt[:allow_negative] == true || opt[:allow_negative] == false)
    end

    attr_accessor :format
    attr_accessor :allow_negative
    attr_reader :separator, :delimiter

    # @param value [String]
    # @param args [Hash]
    # @option args [String] :format the format
    # @return [String]
    def to_us(value)
      value = value.gsub('-', '') unless allow_negative
      value = value.gsub('/', '')

      case format
      when :de
        int = value.gsub('.', '')

        if int.match(',').to_a.any?
          result = int.split(',')
          int = result[0]
          frac = result[1]
          return int + '.' + frac
        else
          int
        end
      end
    end

    class << self
      def to_us(value)
        new.to_us(value)
      end
    end

    private
    def set_format(locale)
      case locale
      when :de
        @separator = ','
        @delimiter = '.'
      else
        raise CurrencyParser::InvalidFormatError
      end
    end
  end

end
