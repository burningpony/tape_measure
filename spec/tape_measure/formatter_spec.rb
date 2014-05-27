require 'spec_helper'

describe TapeMeasure::Formatter do

  it 'when simple number' do
    expect(TapeMeasure::Formatter.new(1).mixed_number).to eq("1\"")
  end

  it 'when multiple feet' do
    expect(TapeMeasure::Formatter.new(47).mixed_number).to eq("3' 11\"")
  end

  it 'when multiple feet with fraction' do
    expect(TapeMeasure::Formatter.new(47.333).mixed_number)
    .to eq("3' 11 1/3\"")
  end

  it 'when no length' do
    expect(TapeMeasure::Formatter.new(0.0).mixed_number)
    .to eq('')
  end

  it 'when called via class method helper' do
    expect(TapeMeasure.format(1)).to eq("1\"")
  end
end
