# encoding: utf-8

require 'spec_helper'

describe CurrencyParser do
  describe "#to_string" do
    it "should parse with a default `:de` format" do
      expect(CurrencyParser.to_string "1,23").to eq("1.23")
    end

    it "should parse the `:de` format correctly" do
      expect(CurrencyParser.to_string "0").to eq("0")
      expect(CurrencyParser.to_string "0,0").to eq("0.0")
      expect(CurrencyParser.to_string "0,00").to eq("0.00")
      expect(CurrencyParser.to_string "1.000,00").to eq("1000.00")
      expect(CurrencyParser.to_string "1").to eq("1")
      expect(CurrencyParser.to_string "1,23").to eq("1.23")
      expect(CurrencyParser.to_string "12,3").to eq("12.3")
      expect(CurrencyParser.to_string "12,30").to eq("12.30")
      expect(CurrencyParser.to_string "-1,23").to eq("1.23")
      expect(CurrencyParser.to_string "-1,23/-").to eq("1.23")
      expect(CurrencyParser.to_string "1,23/-").to eq("1.23")
    end
  end
end
