module TapeMeasure
  # Format numbers in mixed numbers
  
  class Parser
    def initialize(string)

      Citrus.load 'lib/tape_measure/length_grammar'

      @string  = string
      return nil if @number.blank?
      return 0.0 if @number == 0.0

      parse

    end

    def parse
      begin
        @parsed = LengthGrammer.parse(string).value
      rescue
        @parsed.error
      end
    end
  end
end