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
    TapeMeasure.parse(6).should eq 6
  end

  it 'can handle nil' do
    TapeMeasure.parse(nil).should eq nil
  end

  it 'can handle empty string' do
    TapeMeasure.parse("").should eq nil
  end

  describe :grammar do
    it 'can add' do
      TapeMeasure::Parser.new('(8+2)').value.should eq 10
      TapeMeasure::Parser.new('8+2').value.should eq 10
      TapeMeasure::Parser.new('(8 + 2)').value.should eq 10
      TapeMeasure::Parser.new('8 + 2').value.should eq 10
    end
    it 'can subtract' do
      TapeMeasure::Parser.new('4 - 2').value.should eq 2
    end

    it 'can evaluate parens' do
      TapeMeasure::Parser.new('(8*2)').value.should eq 16
      TapeMeasure::Parser.new('(8)*(2)*(2)').value.should eq 32
      TapeMeasure::Parser.new('(8)*(2)').value.should eq 16
      TapeMeasure::Parser.new('(8*2)').value.should eq 16
      TapeMeasure::Parser.new('(8)(2)').value.should eq 10
      TapeMeasure::Parser.new('(2+8*2+2)*2').value.should eq 40
    end

    it 'will perform flops' do
      expect(TapeMeasure::Parser.new('15.5 + 12.7').value).to eq(28.2)
      expect(TapeMeasure::Parser.new('7.24 - 4.12').value).to eq(3.12)
      expect(TapeMeasure::Parser.new('4.5 * 3').value).to eq(13.5)
      expect(TapeMeasure::Parser.new('5.5 / 11').value).to eq(0.5)
    end

    it 'can multiply rationals' do
      TapeMeasure::Parser.new('(4/4 + 4)').value.should eq 5
      TapeMeasure::Parser.new('(3/4 +4/4)').value.should eq '7/4'.to_r
      TapeMeasure::Parser.new('(3/4 *4/1)').value.should eq '12/4'.to_r
    end

    it 'can multiply rationals and fractions' do
      TapeMeasure::Parser.new('(3/4 +1.0)').value.should eq 7.0 / 4.0
    end

    describe 'recognizes mixed numbers' do

      it 'recognizes inches' do
        TapeMeasure::Parser.new('2 inches').value.should eq 2
        TapeMeasure::Parser.new('2 "').value.should eq 2
        TapeMeasure::Parser.new('2in').value.should eq 2
      end

      it 'recognizes feet' do
        TapeMeasure::Parser.new('2 feet').value.should eq 24
        TapeMeasure::Parser.new('2\'').value.should eq 24
        TapeMeasure::Parser.new('2ft').value.should eq 24
      end

      it 'converts meters' do
        TapeMeasure::Parser.new('1 meter').value.should eq 39.3701
        TapeMeasure::Parser.new('1m').value.should eq 39.3701
      end

      describe 'converts centimeters' do
        it 'with whitespace' do
          TapeMeasure::Parser.new('127 cm').value.should eq 50
        end
        it 'without whitespace' do
          TapeMeasure::Parser.new('127cm').value.should eq 50
        end
      end

      it 'converts millimeters' do
        TapeMeasure::Parser.new('1270 mm').value.should eq 50
        TapeMeasure::Parser.new('1270mm').value.should eq 50
      end
    end
  end

  describe :unit_conversion do

    it 'number + space + string unit twice to inches' do
      TapeMeasure::Parser.new('4feet 2inches').value.should eq 50
    end

    it 'number + string unit twice to inches' do
      TapeMeasure::Parser.new("4'2\"").value.should eq 50
    end

    it 'number + string unit twice to inches' do
      TapeMeasure::Parser.new('3ft10in').value.should eq 46
    end

    it 'number + string unit twice to inches' do
      TapeMeasure::Parser.new('3ft13in').value.should eq 49
    end

    it 'converts single quotes to feet' do
      TapeMeasure::Parser.new("1\' 2 1/3\"").value
      .should eq(12 + 2 + (1 / 3).to_f.round(4))
    end

    it 'lots of junk spaces' do
      TapeMeasure::Parser.new("     1\' 2      1/3\"     ").value
      .should eq(12 + 2 + (1 / 3).to_f.round(4))
    end

    it 'converts decimal inches' do
      TapeMeasure::Parser.new("     1\' 2.24\"     ").value.should eq 14.24
    end

    it 'converts decimal feet' do
      TapeMeasure::Parser.new("     1.1\'      ").value.should eq 13.2
    end

    it 'converts rational feet' do
      TapeMeasure::Parser.new("     1 1/10\'      ").value.should eq 13.2
    end

    it 'handle a shit ton of units when someone thinks they are funny' do
      TapeMeasure::Parser.new("1' 2' 3' 127cm").value.should eq 122.0
    end

    it 'handles no units' do
      TapeMeasure::Parser.new('5').value.should eq 5
    end

    # expected to hand parens in this way
    it 'handles paren parsing as predicted' do
      TapeMeasure::Parser.new('(5) 5').value.should eq 10
      TapeMeasure::Parser.new('(5)(5)(5)').value.should eq 15
    end

    it 'handles no units' do
      TapeMeasure::Parser.new('(5+5) 5 (5+5)').value.should eq 25
    end

    it 'order of operations' do
      TapeMeasure::Parser.new('(5+5*5) 5/5').value.should eq 31
    end

  end

  describe :calculator do
    it 'with length style input' do
      expect(TapeMeasure::Parser.new('15.5\' + 12.7').value).to eq(198.7)
      expect(TapeMeasure::Parser.new('7 1/3 inches - 4.12mm').value)
      .to eq(7.1711)
      expect(TapeMeasure::Parser.new('4.5 * 3').value).to eq(13.5)
      expect(TapeMeasure::Parser.new('5.5 / 11').value).to eq(0.5)
      expect(TapeMeasure::Parser.new('1 ft * 1 inch').value).to eq(12)
      expect(TapeMeasure::Parser.new('(3 ft 1/4") * 3 1/2 inch').value).to eq(126.875)
      expect(TapeMeasure::Parser.new('(3 ft 1/4") * 3 1/2 inch * 4/4" ').value).to eq(126.875)
      expect(TapeMeasure::Parser.new('(3 ft 1/4") * 3 1/2 inch * 3/4" ').value).to eq(95.15625)
    end
    it 'when no brackets to define order of operations' do 
      expect(TapeMeasure::Parser.new('3\' 1/4" * 3 1/2"').value).to eq(126.875)
      expect(TapeMeasure::Parser.new('3\' 1/4" * 3 1/2" * 4/4" ').value).to eq(126.875)
      expect(TapeMeasure::Parser.new('3\' 1/4" * 3 1/2" * 3/4" ').value).to eq(95.15625)
    end
  end
  it 'when called via class method helper' do
    expect(TapeMeasure.parse("1\"")).to eq(1)
  end
end
