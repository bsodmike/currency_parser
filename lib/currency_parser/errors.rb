# encoding: utf-8

module CurrencyParser
  # A general CurrencyParser exception.
  class Error < StandardError
    def initialize(msg = "Boom Shakalaka!! You've triggered a #{self}")
      super
    end
  end

  # Raised when an invalid format is encounted.
  class InvalidFormatError < Error
  end
end
