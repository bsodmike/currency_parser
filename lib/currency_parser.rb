# encoding: utf-8

# Defaults:
# * :format - The default format is `:de`
# * :separator - The character to use after the integer part, default is ','
# * :delimiter - The character to use between every 3 digits of the integer part, default '.'
module CurrencyParser
  @format = :de
  @separator = ','
  @delimiter = '.'
  class << self
    attr_accessor :format
    attr_reader :separator, :delimiter
  end

  module ParserInstanceMethods
    # @param value [String]
    # @param args [Hash]
    # @option args [String] :format the format
    # @return [String]
    def to_string(value, *args)
      opt = args.last.is_a?(Hash) ? args.pop : {}
      set_format(opt[:format]) if opt[:format]

      value = value.gsub('-', '').gsub('/', '')

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

    private
    def set_format(locale)
      case locale
      when :de
        format = :de
        @separator = ','
        @delimiter = '.'
      end
    end
  end

  extend ParserInstanceMethods
end
