require 'citrus'
require 'ruby_units/namespaced'
Citrus.load File.expand_path("../length_grammar", __FILE__)

module TapeMeasure
  # Parse Strings into units and math them
  class Parser
    attr_reader :value, :match, :unit, :scalar

    def initialize(string)
      @string  = string
      if @string.is_a?(String)
        parse
      else
        @value = string
      end
    end

    def parse
      begin
        mixed_value = LengthGrammar.parse(@string.strip).value
        @unit = mixed_value.units
        @scalar = mixed_value.scalar
        @value = mixed_value.compatible?("in") ? (mixed_value >> "in").scalar.round(4) : @scalar.to_f

        @match = true
      rescue => ex
        ex.message
        @match = false
      end
    end
  end

  # Class method helper to make call easier
  class << self
    def parse(string)
      Parser.new(string).value
    end

    def match?(string)
      Parser.new(string).match
    end

    def scalar(string)
      Parser.new(string).scalar
    end

    def unit(string)
      Parser.new(string).unit
    end
  end
end
