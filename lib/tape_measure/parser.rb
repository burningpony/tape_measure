require 'citrus'
require 'ruby_units/namespaced'
Citrus.load File.expand_path("../length_grammar", __FILE__)

module TapeMeasure
  # Parse Strings into units and math them
  class Parser
    attr_reader :value

    def initialize(string)
      @string  = string
      return @string.blank? if @string == 0.0
      parse
    end

    def parse
      @value = LengthGrammar.parse(@string.strip).value
    rescue => ex
      ex.message
    end
  end

  # Class method helper to make call easier
  class << self
    def parse(string)
      Parser.new(string).value
    end
  end
end
