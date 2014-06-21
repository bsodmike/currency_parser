# encoding: utf-8
require 'spec_helper'
require 'currency_parser/errors'

describe CurrencyParser::Parser do
  let(:subject){ CurrencyParser::Parser.new }

  it "should raise InvalidFormatError if initialized with unknown format without delimeter and separator" do
    expect{ CurrencyParser::Parser.new(:ch) }.to raise_error(CurrencyParser::InvalidFormatError)
  end

  it "should not raise InvalidFormatError if initialized with unknown format with delimeter and separator" do
    expect{ CurrencyParser::Parser.new(:fr, :separator => ',', :delimeter => ' ') }.not_to raise_error()
  end

  describe "::to_us" do
    let(:subject){ CurrencyParser::Parser }
    it "should parse from `:de` format to `:us` format" do
      expect(subject.to_us "1,23", :de, false).to eq("1.23")
    end
  end

  describe "#to_us" do
    it "should parse with a default `:de` format" do
      expect(subject.to_us "1,23").to eq("1.23")
    end

    it "should parse the `:de` format correctly" do
      expect(subject.to_us "0").to eq("0")
      expect(subject.to_us "0,0").to eq("0.0")
      expect(subject.to_us "0,00").to eq("0.00")
      expect(subject.to_us "1.000,00").to eq("1,000.00")
      expect(subject.to_us "1").to eq("1")
      expect(subject.to_us "1,23").to eq("1.23")
      expect(subject.to_us "12,3").to eq("12.3")
      expect(subject.to_us "12,30").to eq("12.30")
      expect(subject.to_us "-1,23").to eq("1.23")
      expect(subject.to_us "-1,23/-").to eq("1.23")
      expect(subject.to_us "1,23/-").to eq("1.23")
    end

    context "when allowed negative values" do
      let(:subject){ CurrencyParser::Parser.new(:de, :allow_negative => true) }
      it "should parse correctly" do
        expect(subject.to_us "-1,23").to eq("-1.23")
      end
    end
  end

  describe "#to_de" do
    let(:subject){ CurrencyParser::Parser.new(:pl) }
    it "should parse from `:pl` format to `:de` format" do
      expect(subject.to_de "0").to eq("0")
      expect(subject.to_de "0,0").to eq("0,0")
      expect(subject.to_de "0,00").to eq("0,00")
      expect(subject.to_de "1 000,00").to eq("1.000,00")
      expect(subject.to_de "1").to eq("1")
      expect(subject.to_de "1,23").to eq("1,23")
      expect(subject.to_de "12,3").to eq("12,3")
      expect(subject.to_de "12,30").to eq("12,30")
      expect(subject.to_de "-1,23").to eq("1,23")
      expect(subject.to_de "-1,23/-").to eq("1,23")
      expect(subject.to_de "1,23/-").to eq("1,23")
      expect(subject.to_de "100 123,11").to eq("100.123,11")
    end
    
    context "when allowed negative values" do
      let(:subject){ CurrencyParser::Parser.new(:pl, :allow_negative => true) }
      it "should parse correctly" do
        expect(subject.to_de "-1,23").to eq("-1,23")
      end
    
    end
  end
end
