# encoding: utf-8

module CurrencyParser
  autoload :Errors, 'currency_parser/errors'

  class Parser
      
    @@formats = {
      # [ separator, delimeter ]
      :de => [ ',', '.' ],
      :us => [ '.', ',' ],
      :pl => [ ',', ' ' ]
    }

    # Initializer
    #
    # @param [Symbol] format of the initial string
    # @param [Hash] opts the options to create a object with
    # @option opts [String] :separator
    #   the character to use after the integer part
    # @option opts [String] :delimeter
    #   the character to use between every 3 digits of the integer part
    # @option opts [String] :allow_negative
    #   allow negative numbers
    def initialize(format = :de, *args)

      # leaving constructor arguments without modification for backward compatibility
      
      @format = format
      opts = args.last.is_a?(Hash) ? args.pop : {}
  
      unless @@formats.include?(format)
        if (opts.include? :separator) && (opts.include? :delimeter)
          @@formats.merge!(format => [ opts[:separator], opts[:delimeter] ])
        else
          raise CurrencyParser::InvalidFormatError
        end
      end

      # negative value
      @allow_negative = false
      @allow_negative = opts[:allow_negative] if opts[:allow_negative] && (!!opts[:allow_negative] ==  opts[:allow_negative])
    end

    attr_accessor :format
    attr_accessor :allow_negative

    # Returns separator for assigned format
    #
    # @return [String]
    def separator
      @@formats[@format][0]
    end

    # Returns delimeter for assigned format
    #
    # @return [String]
    def delimeter
      @@formats[@format][1]
    end

    # Converts to US format (instance method)
    #
    # @param value [String]
    # @return [String]
    def to_us(value)
      self.class.convert_format(value, @format, :us, @allow_negative)
    end
    
    # Converts to US format (class method)
    #
    # @param value [String]
    # @param from_format [Symbol] initial format
    # @param allow_negative [Boolean]
    # @return [String]
    def self.to_us(value, from_format, allow_negative)
      convert_format(value, from_format, :us, allow_negative)
    end
    
    # Converts to German format (instance method)
    #
    # @param value [String]
    # @return [String]
    def to_de(value)
      self.class.convert_format(value, @format, :de, @allow_negative)
    end
    
    # Converts to German format (class method)
    #
    # @param value [String]
    # @param from_format [Symbol] initial format
    # @param allow_negative [Boolean]
    # @return [String]
    def self.to_de(value, from_format, allow_negative)
      convert_format(value, from_format, :de, allow_negative)
    end

    # Converts to Polish format (instance method)
    #
    # @param value [String]
    # @return [String]
    def to_pl(value)
      self.class.convert_format(value, @format, :pl, @allow_negative)
    end
    
    # Converts to Polish format (class method)
    #
    # @param value [String]
    # @param from_format [Symbol] initial format
    # @param allow_negative [Boolean]
    # @return [String]
    def self.to_pl(value, from_format, allow_negative)
      convert_format(value, from_format, :pl, allow_negative)
    end

    private

    # Method converting given currency string to one of supported formats
    #
    # @param value [String]
    # @param format_from [Symbol] initial format
    # @param format_to [Symbol] result format
    # @param allow_negative [Boolean]
    # @return [String]
    def self.convert_format(value, format_from, format_to, allow_negative)

      raise CurrencyParser::InvalidFormatError unless @@formats.include?(format_from) 

      value.gsub!('-', '') unless allow_negative
      value.gsub!('/', '')

      separator_from, separator_to = @@formats[format_from][0], @@formats[format_to][0]
      delimeter_from, delimeter_to = @@formats[format_from][1], @@formats[format_to][1]

      # string should never have more than one separator
      raise CurrencyParser::InvalidFormatError if value.count(separator_from) > 1

      # remove delimeter characters
      value.gsub!(delimeter_from, '')

      if value.include? separator_from
        int, frac = value.split(separator_from)
      else
        int, frac = value, ''
      end

      # insert delimeter character at proper positions
      int.gsub!(/(\d)(?=(\d{3})+(?!\d))/, "\\1#{delimeter_to}")
    
      int + unless frac.empty? then separator_to + frac else '' end
    end

  end

end
