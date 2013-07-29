# encoding: utf-8

require 'spec_helper'

describe CurrencyParser::Parser do
  let(:subject){ CurrencyParser::Parser.new }

  describe "::to_us" do
    let(:subject){ CurrencyParser::Parser }
    it "should parse with a default `:de` format" do
      expect(subject.to_us "1,23").to eq("1.23")
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
      expect(subject.to_us "1.000,00").to eq("1000.00")
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
end
