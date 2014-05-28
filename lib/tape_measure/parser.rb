module TapeMeasure
  # Format numbers in mixed numbers
  require 'citrus'
  class Parser
    def initialize(string)
      @string  = string
      return @string.blank? if @string == 0.0

      parse

    end

    def parse
      Citrus.load 'lib/tape_measure/length_grammar'
      begin
        @parsed = LengthGrammar.parse(@string.strip).value
      rescue => ex
        ex.message
      end
    end
  end
end