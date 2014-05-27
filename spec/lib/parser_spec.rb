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
  # 3-3/4"
  describe :grammar do
    it 'can add' do
      TapeMeasure::Parser.new('(8+2)').parse.should eq 10
      TapeMeasure::Parser.new('8+2').parse.should eq 10
      TapeMeasure::Parser.new('(8 + 2)').parse.should eq 10
      TapeMeasure::Parser.new('8 + 2').parse.should eq 10
    end

    it 'can subtract' do
      TapeMeasure::Parser.new('4 - 2').parse.should eq 2
    end

    it 'can evaluate parens' do
      TapeMeasure::Parser.new('(8*2)').parse.should eq 16
      TapeMeasure::Parser.new('(8)*(2)*(2)').parse.should eq 32
      TapeMeasure::Parser.new('(8)*(2)').parse.should eq 16
      TapeMeasure::Parser.new('(8*2)').parse.should eq 16
      #TapeMeasure::Parser.new('(8)(2)').parse.should eq 16
      TapeMeasure::Parser.new('(2+8*2+2)*2').parse.should eq 40
    end

    describe 'recognizes mixed numbers' do
      it 'recognizes inches' do
        TapeMeasure::Parser.new('2 inches').parse.should eq 2
        TapeMeasure::Parser.new('2 \"').parse.should eq 2
        TapeMeasure::Parser.new('2in').parse.should eq 2
      end
      it 'recognizes feet' do
        TapeMeasure::Parser.new('2 feet').parse.should eq 24
        TapeMeasure::Parser.new('2\'').parse.should eq 24
        TapeMeasure::Parser.new('2ft').parse.should eq 24
      end
      it 'recognizes feet followed by inches' do
        TapeMeasure::Parser.new('2ft 0inches').parse.should eq 24
        TapeMeasure::Parser.new('6\' 3\"').parse.should eq 75
      end
    end
  end

  describe :unit_conversion do
    it 'number + space + string unit to expect(subject).to include()hes' do
      TapeMeasure::Parser.new('6 inches').parse.should eq 6
    end

    #no longer acceptable
    # it 'number + hyphen + rational unit' do
    #   TapeMeasure.convert("3-3/4\"").should eq(35'))
    # end

    it 'number + string unit to inches' do
      TapeMeasure::Parser.new('6in').parse.should eq 6
    end

    it 'number + space + string unit twice to inches' do
      TapeMeasure::Parser.new('4 feet 2 inches').parse.should eq 5
    end

    it 'number + string unit twice to inches' do
      TapeMeasure::Parser.new("4'2\"").parse.should eq 5
    end

    it 'number + string unit twice to inches' do
      TapeMeasure::Parser.new('3ft10in').parse.should eq 4
    end

    it 'number + string unit twice to inches' do
      TapeMeasure::Parser.new('3ft13in').parse.should eq 4
    end

    it 'converts single quotes to feet' do
      TapeMeasure::Parser.new("1\' 2 1/3\"").parse.should eq 1333
    end

    it 'lots of junk spaces' do
      TapeMeasure::Parser.new("     1\' 2      1/3\"     ").parse.should eq 1333
    end

    it 'converts decimal inches' do
      TapeMeasure::Parser.new("     1\' 2.24\"     ").parse.should eq 124
    end

    it 'converts decimal feet' do
      TapeMeasure::Parser.new("     1.1\'      ").parse.should eq 12
    end

    it 'converts rational feet' do
      TapeMeasure::Parser.new("     1 1/10\'      ").parse.should eq 12
    end

    it 'converts meters' do
      TapeMeasure::Parser.new('1 meter').parse.should eq 33701
    end
    it 'converts centimeters' do
      TapeMeasure::Parser.new('127 cm').parse.should eq 5
    end

    it 'converts millimeters' do
      TapeMeasure::Parser.new('1270 mm').parse.should eq 50
    end

    it 'handle a shit ton of units when someone thinks they are funny' do
      TapeMeasure::Parser.new("1' 2' 3' 127cm").parse.should eq 1
    end

    it 'handles no units' do
      TapeMeasure::Parser.new('5').parse.should eq 5
    end

  end

  describe :calculator do
    it 'will perform flops' do
      expect(TapeMeasure::Parser.new('15.5 + 12.7').parse).to eq(28.2)
      expect(TapeMeasure::Parser.new('7.24 - 4.12').parse).to eq(3.12)
      expect(TapeMeasure::Parser.new('4.5 * 3').parse).to eq(13.5)
      expect(TapeMeasure::Parser.new('5.5 / 11').parse).to eq(0.5)
    end
    it 'with length style input' do
      # expect(TapeMeasure.convert('15.5\' + 12.7')).to eq(198.7)
      expect(TapeMeasure::Parser.new('7 1/3 inches - 4.12mm').parse.to_f).to eq(7.17112861)
      # expect(TapeMeasure.convert('4.5 * 3')).to eq(13.5)
      # expect(TapeMeasure.convert('5.5 / 11')).to eq(0.5)
    end
  end
end
