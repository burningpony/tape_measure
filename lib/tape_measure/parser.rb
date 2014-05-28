require 'citrus'
require 'ruby_units/namespaced'
Citrus.load 'lib/tape_measure/length_grammar'

module TapeMeasure
  # Parse Strings into units and math them
  class Parser
    def initialize(string)
      @string  = string
      return @string.blank? if @string == 0.0
      parse
    end

    def parse
      @parsed = LengthGrammar.parse(@string.strip).value
    rescue => ex
      ex.message
    end
  end
end
