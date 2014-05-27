module TapeMeasure
  # Format numbers in mixed numbers
  class Formatter
    attr_reader :mixed_number

    def initialize(number = 0.0)
      @number     = number
      @unit_array = []
      @feet       = @number.div(12)
      @raw_inches = @number.remainder(12)
      @inches     = @raw_inches.to_i
      @fraction   = @raw_inches.remainder(1).to_r.rationalize(0.01)

      format_feet
      format_inches
      format_fraction

      @mixed_number = @unit_array.compact.join
    end

    def format_feet
      @unit_array << "#{@feet}'" if @feet > 0
    end

    def format_inches
      if @inches > 0
        @unit_array << ' ' if @feet > 0
        @unit_array << "#{@inches}"
      end
    end

    def format_fraction
      @unit_array << ' ' if @fraction > 0 && @inches > 0
      @unit_array << "#{@fraction}" if @fraction > 0
      @unit_array << "\"" if @raw_inches > 0
    end
  end

  # Class method helper to make call easier
  class << self
    def format(number)
      Formatter.new(number).mixed_number
    end
  end
end
