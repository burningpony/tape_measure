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
      TapeMeasure.formatter.new(1)
    end

  #   it 'can subtract' do
  #     m = LengthGrammar.parse '4 - 2'
  #     m.value.should eq 2
  #   end

  #   it 'can evaluate parens' do
  #     LengthGrammar.parse('(8*2)').value.should eq 16
  #     LengthGrammar.parse('(8)*(2)*(2)').value.should eq 32
  #     LengthGrammar.parse('(8)*(2)').value.should eq 16
  #     LengthGrammar.parse('(8*2)').value.should eq 16
  #     #LengthGrammar.parse('(8)(2)').value.should eq 16
  #     LengthGrammar.parse('(2+8*2+2)*2').value.should eq 40
  #   end

  #   describe 'recognizes mixed numbers' do
  #     it 'recognizes inches' do
  #       LengthGrammar.parse('2 inches').value.should eq 2
  #       LengthGrammar.parse('2 \"').value.should eq 2
  #       LengthGrammar.parse('2in').value.should eq 2
  #     end
  #     it 'recognizes feet' do
  #       LengthGrammar.parse('2 feet').value.should eq 24
  #       LengthGrammar.parse('2\'').value.should eq 24
  #       LengthGrammar.parse('2ft').value.should eq 24
  #     end
  #     it 'recognizes feet followed by inches' do
  #       LengthGrammar.parse('2ft 0inches').value.should eq 24
  #       LengthGrammar.parse('6\' 3\"').value.should eq 75
  #     end
  #   end
  # end

  # describe :to_mixed_number do
  #   it 'returns a mixed number' do
  #     TapeMeasure.to_mixed_number(74.3333).should eq("6' 2-1/3\"")
  #   end

  #   it 'only displays feet if divisible by 12' do
  #     TapeMeasure.to_mixed_number(72).should eq("6'")
  #   end

  #   it 'only displays feet and inches if divisible by 1' do
  #     TapeMeasure.to_mixed_number(74).should eq("6' 2\"")
  #   end

  #   it 'only displays inches if divisible by 1 ' do
  #     TapeMeasure.to_mixed_number(1).should eq("1\"")
  #   end

  #   it 'only displays fractions' do
  #     TapeMeasure.to_mixed_number(0.3333).should eq("1/3\"")
  #   end

  #   it 'only displays if line is 0' do
  #     TapeMeasure.to_mixed_number(BigDecimal 0).should eq(0.0)
  #   end

  #   it 'it returns null if a blank string is given' do
  #     TapeMeasure.to_mixed_number('').should eq(nil)
  #   end
  # end

  # describe :unit_conversion do
  #   it 'number + space + string unit to expect(subject).to include()hes' do
  #     LengthGrammar.parse('6 inches').value.should eq 6
  #   end

  #   #no longer acceptable
  #   # it 'number + hyphen + rational unit' do
  #   #   TapeMeasure.convert("3-3/4\"").should eq(35'))
  #   # end

  #   it 'number + string unit to inches' do
  #     LengthGrammar.parse('6in').value.should eq 6
  #   end

  #   it 'number + space + string unit twice to inches' do
  #     LengthGrammar.parse('4 feet 2 inches').value.should eq 5
  #   end

  #   it 'number + string unit twice to inches' do
  #     LengthGrammar.parse("4'2\"").value.should eq 5
  #   end

  #   it 'number + string unit twice to inches' do
  #     LengthGrammar.parse('3ft10in').value.should eq 4
  #   end

  #   it 'number + string unit twice to inches' do
  #     LengthGrammar.parse('3ft13in').value.should eq 4
  #   end

  #   it 'converts single quotes to feet' do
  #     LengthGrammar.parse("1\' 2 1/3\"").value.should eq 1333
  #   end

  #   it 'lots of junk spaces' do
  #     LengthGrammar.parse("     1\' 2      1/3\"     ").value.should eq 1333
  #   end

  #   it 'converts decimal inches' do
  #     LengthGrammar.parse("     1\' 2.24\"     ").value.should eq 124
  #   end

  #   it 'converts decimal feet' do
  #     LengthGrammar.parse("     1.1\'      ").value.should eq 12
  #   end

  #   it 'converts rational feet' do
  #     LengthGrammar.parse("     1 1/10\'      ").value.should eq 12
  #   end

  #   it 'converts meters' do
  #     LengthGrammar.parse('1 meter').value.should eq 33701
  #   end
  #   it 'converts centimeters' do
  #     LengthGrammar.parse('127 cm').value.should eq 5
  #   end

  #   it 'converts millimeters' do
  #     LengthGrammar.parse('1270 mm').value.should eq 5
  #   end

  #   it 'handle a shit ton of units when someone thinks they are funny' do
  #     LengthGrammar.parse("1' 2' 3' 127cm").value.should eq 1
  #   end

  #   it 'handles no units' do
  #     LengthGrammar.parse('5').value.should eq 5
  #   end

  # end

  # describe :calculator do
  #   it 'will perform flops' do
  #     expect(LengthGrammar.parse('15.5 + 12.7').value).to eq(28.2)
  #     expect(LengthGrammar.parse('7.24 - 4.12').value).to eq(3.12)
  #     expect(LengthGrammar.parse('4.5 * 3').value).to eq(13.5)
  #     expect(LengthGrammar.parse('5.5 / 11').value).to eq(0.5)
  #   end
  #   it 'with length style input' do
  #     # expect(TapeMeasure.convert('15.5\' + 12.7')).to eq(198.7)
  #     expect(LengthGrammar.parse('7 1/3 inches - 4.12mm').value.to_f).to eq(7.17112861)
  #     # expect(TapeMeasure.convert('4.5 * 3')).to eq(13.5)
  #     # expect(TapeMeasure.convert('5.5 / 11')).to eq(0.5)
  #   end
  # end

  # describe 'string monkeypatch' do
  #   it 'will return parsed value' do
  #     expect(LengthGrammar.parse("1' 2' 3' 127cm").value.to_mixed_f).to eq 1
  #   end
  end
end
