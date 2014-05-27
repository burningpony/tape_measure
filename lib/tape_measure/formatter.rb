
module TapeMeasure
  # Format numbers in mixed numbers
  class Formatter
    def initialize(number)

      @number  = number || 0.0
      return nil if @number.blank?
      return 0.0 if @number == 0.0

      parse
      output

    end

    def parse
      feet =  ( @number.div 12)
      inches = @number.remainder(12)
      fraction = inches.remainder(1).to_r.rationalize(0.01)

      @feet_string = "#{feet}'" if feet > 0
      @inches_seperator = ' ' if inches.to_i > 0 && feet > 0
      @inches_string = "#{inches.to_i}" if inches.to_i > 0
      @fraction_string = "#{fraction}" if fraction > 0
      @fraction_seperator = '-' if inches.to_i > 0 && fraction > 0
      @inches_unit_string = "\"" if inches > 0  || fraction > 0
    end

    def output
      [
        @feet_string,
        @inches_seperator,
        @inches_string,
        @fraction_seperator,
        @fraction_string,
        @inches_unit_string
      ].compact.join
    end
  end
end
