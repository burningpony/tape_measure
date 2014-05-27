module TapeMeasure
  # Format numbers in mixed numbers

  class Parser
    def initialize(string)
      Citrus.load 'lib/tape_measure/length_grammar'

      @string  = string
      return nil if @number.blank?
      return 0.0 if @number == 0.0

      parse
      output
    end

    def parse
      @parsed = LengthGrammer.parse(string)
    end

    def output
      begin
        output = @parsed.value
      rescue
        output = output.message
      ensure
        output
      end
    end
  end
end
