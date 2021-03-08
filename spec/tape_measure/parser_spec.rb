require 'spec_helper'

describe TapeMeasure do
  # 6 inches
  # 6in * 4ft
  # 6"
  # 4 feet 2 inches
  # 4'2"
  # 4 ' 2 "
  # 3 feet
  # 3'
  # 3 '
  # 3ft
  # 3ft10in
  # 3ft 13in (should convert to 4'1")
  # 1' 2 1/3"
  #      1' 2      1/3"
  #      1' 2.24"
  #      1.1'
  #      1 1/10'
  # 1' 2' 3' 127cm
  # 5 (assumes inches)
  # 3-3/4" = 2.75

  it 'can handle integer' do
    expect(TapeMeasure.parse(6)).to eq 6
  end

  it 'can handle nil' do
    expect(TapeMeasure.parse(nil)).to eq nil
  end

  it 'can handle empty string' do
    expect(TapeMeasure.parse("")).to eq nil
  end

  describe :grammar do
    it 'can add' do
      expect(TapeMeasure::Parser.new('(8+2)').value).to eq 10
      expect(TapeMeasure::Parser.new('8+2').value).to eq 10
      expect(TapeMeasure::Parser.new('(8 + 2)').value).to eq 10
      expect(TapeMeasure::Parser.new('8 + 2').value).to eq 10
    end
    it 'can subtract' do
      expect(TapeMeasure::Parser.new('4 - 2').value).to eq 2
    end

    it 'can evaluate parens' do
      expect(TapeMeasure::Parser.new('(8*2)').value).to eq 16
      expect(TapeMeasure::Parser.new('(8)*(2)*(2)').value).to eq 32
      expect(TapeMeasure::Parser.new('(8)*(2)').value).to eq 16
      expect(TapeMeasure::Parser.new('(8*2)').value).to eq 16
      expect(TapeMeasure::Parser.new('(8)(2)').value).to eq 10
      expect(TapeMeasure::Parser.new('(2+8*2+2)*2').value).to eq 40
    end

    it 'will perform flops' do
      expect(TapeMeasure::Parser.new('15.5 + 12.7').value).to eq(28.2)
      expect(TapeMeasure::Parser.new('7.24 - 4.12').value).to eq(3.12)
      expect(TapeMeasure::Parser.new('4.5 * 3').value).to eq(13.5)
      expect(TapeMeasure::Parser.new('5.5 / 11').value).to eq(0.5)
    end

    it 'can multiply rationals' do
      expect(TapeMeasure::Parser.new('(4/4 + 4)').value).to eq 5
      expect(TapeMeasure::Parser.new('(3/4 +4/4)').value).to eq Rational(7, 4)
      expect(TapeMeasure::Parser.new('(3/4 *4/1)').value).to eq Rational(12, 4)
    end

    it 'can multiply rationals and fractions' do
      expect(TapeMeasure::Parser.new('(3/4 +1.0)').value).to eq 7.0 / 4.0
    end

    it 'can handle complex rationals' do
      expect(TapeMeasure::Parser.new('(77/88 mm)').value).to eq Rational(35,1016)
      expect(TapeMeasure::Parser.new('(77/88 mm)').match).to eq true
      expect(TapeMeasure::Parser.new('(77/88 mm)').scalar).to eq Rational(77,88)
      expect(TapeMeasure::Parser.new('(77/88 mm)').unit).to eq "mm"
    end

    describe 'recognizes mixed numbers' do

      it 'recognizes inches' do
        expect(TapeMeasure::Parser.new('2 inches').value).to eq 2
        expect(TapeMeasure::Parser.new('2 "').value).to eq 2
        expect(TapeMeasure::Parser.new('2in').value).to eq 2
      end

      it 'recognizes feet' do
        expect(TapeMeasure::Parser.new('2 feet').value).to eq 24
        expect(TapeMeasure::Parser.new('2\'').value).to eq 24
        expect(TapeMeasure::Parser.new('2ft').value).to eq 24
      end

      it 'converts meters' do
        expect(TapeMeasure::Parser.new('1 meter').value).to eq Rational(5000, 127)
        expect(TapeMeasure::Parser.new('1m').value).to eq Rational(5000, 127)
      end

      describe 'converts centimeters' do
        it 'with whitespace' do
          expect(TapeMeasure::Parser.new('127 cm').value).to eq 50
        end
        it 'without whitespace' do
          expect(TapeMeasure::Parser.new('127cm').value).to eq 50
        end
      end

      it 'converts millimeters' do
        expect(TapeMeasure::Parser.new('1270 mm').value).to eq 50
        expect(TapeMeasure::Parser.new('1270mm').value).to eq 50
      end
    end
  end

  describe :unit_conversion do

    it 'number + space + string unit twice to inches' do
      expect(TapeMeasure::Parser.new('4feet 2inches').value).to eq 50
    end

    it 'number + symbol unit twice to inches' do
      expect(TapeMeasure::Parser.new("4'2\"").value).to eq 50
    end

    it 'number + string unit twice to inches with no whitespace' do
      expect(TapeMeasure::Parser.new('3ft10in').value).to eq 46
    end

    it 'number + string unit once to inches' do
      expect(TapeMeasure::Parser.new('3ft').value).to eq 36
    end

    it 'number + string unit twice to inches seperated by whitespace' do
      expect(TapeMeasure::Parser.new('3ft 13in').value).to eq 49
    end

    it 'converts single quotes to feet' do
      expect(TapeMeasure::Parser.new("1\' 2 1/3\"").value)
      .to eq(12 + 2 + (1.0 / 3).to_f)
    end

    it 'lots of junk spaces' do
      expect(TapeMeasure::Parser.new("     1\' 2      1/3\"     ").value)
      .to eq(12 + 2 + (1.0 / 3).to_f)
    end

    it 'converts decimal inches' do
      expect(TapeMeasure::Parser.new("     1\' 2.24\"     ").value).to eq 14.24
    end

    it 'converts decimal feet' do
      expect(TapeMeasure::Parser.new("     1.1\'      ").value).to eq 13.2
    end

    it 'converts rational feet' do
      expect(TapeMeasure::Parser.new("     1 1/10\'      ").value).to eq 13.2
    end

    it 'handle a shit ton of units when someone thinks they are funny' do
      expect(TapeMeasure::Parser.new("1' 2' 3' 127cm").value).to eq 122.0
    end

    it 'handles no units' do
      expect(TapeMeasure::Parser.new('5').value).to eq 5
    end

    # expected to hand parens in this way
    it 'handles paren parsing as predicted' do
      expect(TapeMeasure::Parser.new('(5) 5').value).to eq 10
      expect(TapeMeasure::Parser.new('(5)(5)(5)').value).to eq 15
    end

    it 'handles no units' do
      expect(TapeMeasure::Parser.new('(5+5) 5 (5+5)').value).to eq 25
    end

    it 'order of operations' do
      expect(TapeMeasure::Parser.new('(5+5*5) 5/5').value).to eq 31
    end

  end

  describe :calculator do
    it 'with length style input' do
      expect(TapeMeasure::Parser.new('15.5\' + 12.7"').value).to eq(198.7)
      expect(TapeMeasure::Parser.new('7 1/3 inches - 4.12mm').value)
      .to eq(Rational(13661, 1905))
      expect(TapeMeasure::Parser.new('4.5 * 3').value).to eq(13.5)
      expect(TapeMeasure::Parser.new('5.5 / 11').value).to eq(0.5)
      expect(TapeMeasure::Parser.new('1 ft * 1').value).to eq(12)
      expect(TapeMeasure::Parser.new('1 ft * 1').unit).to eq("ft")
      expect(TapeMeasure::Parser.new('1 ft * 1').scalar).to eq(1)
      expect(TapeMeasure::Parser.new('(3 ft 1/4") * 3 1/2').value).to eq(126.875)
      expect(TapeMeasure::Parser.new('(3 ft 1/4") * 3 1/2 * 4/4" ').value).to be_within(1).of(10.572916666666666)
      expect(TapeMeasure::Parser.new('(3 ft 1/4") * 3 1/2 * 4/4" ').unit).to eq("ft*in")
      expect(TapeMeasure::Parser.new('(3 ft 1/4") * 3 1/2 * 3/4 ').value).to eq(Rational(3045, 32))
    end
    it 'when no brackets to define order of operations' do
      expect(TapeMeasure::Parser.new('3\' 1/4" * 3 1/2').value).to eq(126.875)
      expect(TapeMeasure::Parser.new('3\' 1/4" * 3 1/2" * 4/4" ').value).to be_within(1).of(10.572916666666666)
      expect(TapeMeasure::Parser.new('3\' 1/4" * 3 1/2" * 4/4" ').unit).to eq("ft*in^2")
      expect(TapeMeasure::Parser.new('3\' 1/4" * 3 1/2 * 3/4 ').value).to eq(Rational(3045, 32))
    end
  end
  it 'when called via class method helper' do
    expect(TapeMeasure.parse("1\"")).to eq(1)
  end

  describe :match do
    it 'matches' do
      expect(TapeMeasure.match?('3\' 1/4" * 3 1/2" * 3/4" ')).to eq(true)
    end

    it 'does not match' do
      expect(TapeMeasure.match?('3\' 1/4" * 3 1/2" *" ')).to eq(false)
    end

    it 'does not match' do
      expect(TapeMeasure.match?('3\' 1/4" * 3 1/2" x hihi how are you')).to eq(false)
    end
  end
end
