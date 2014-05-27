require "tape_measure/version"

module TapeMeasure
  #LengthConverter
  #handles conversions and parsing of various lengths of lumber
  require 'bigdecimal'
  Citrus.load 'lib/tape_measure/length_grammar'
  class << self

    def convert(string)
      convert_unit(string)
    end

    def to_mixed_number(stored_inches)
      return nil if stored_inches.blank?
      return 0.0 if stored_inches == 0.0
      feet =  ( stored_inches.div 12)
      inches = stored_inches.remainder(12)
      fraction = inches.remainder(1).to_r.rationalize(0.01)

      feet_string = "#{feet}'" if feet > 0
      inches_seperator = ' ' if inches.to_i > 0 && feet > 0
      inches_string = "#{inches.to_i}" if inches.to_i > 0
      fraction_string = "#{fraction}" if fraction > 0
      fraction_seperator = '-' if inches.to_i > 0 && fraction > 0
      inches_unit_string = "\"" if inches > 0  || fraction > 0

      [feet_string,  inches_seperator,  inches_string, fraction_seperator, fraction_string, inches_unit_string].compact.join
    end

    private

    # Parse out Digit + Unit, Loop through multiple iterations && sum them to a common metric

    def convert_unit(string)
      string = string.is_a?(String) ? string : string.to_s
      values = []
      res = []
      "abab".scan(/a/) do |c|
        res << [c, $~.offset(0)[0]]
      end
      puts res.inspect
      string.scan(/\d/).each do |unit_array|
        puts unit_array.inspect
        pos = Regexp.last_match.offset(0)[0]
        puts $~.offset(0)[0]
        unit_array[0] = convert_mixed_number(unit_array[0])
        values[pos] = unit_array.join(' ').to_unit.convert_to('in')

      end
      puts values.inspect
      converted_string.calculate.to_d(9)
      # .compact.inject(:+)  ||  convert_mixed_number(string)
    end

    def check_for_unit(unit_array, expected_units)
      !(unit_array & expected_units).empty?
    end

    def convert_mixed_number(string)
      string = string.strip.gsub(/-/, ' ')
      values = string.split.map do |r|
        Rational(r)
      end
      values.inject(:+) || BigDecimal('0.000')
    end
  end
end

class String
  def to_mixed_f
    LengthConverter.convert(self)
  end
end

class String
  def calculate
    [:+, :-, :*, :/].each do |op|
      factors = self.split(op.to_s)
      return factors.map(&:calculate).inject(op) if factors.size > 1
    end
    to_f # No calculation needed
  end
  alias calc calculate
end
