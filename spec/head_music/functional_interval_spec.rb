require 'spec_helper'

describe FunctionalInterval do
  describe '.get' do
    let(:maj3) { FunctionalInterval.get(:major_third) }
    let(:aug4) { FunctionalInterval.get(:augmented_fourth) }
    let(:dim5) { FunctionalInterval.get('diminished fifth') }

    specify { expect(maj3.lower_pitch).to eq 'C4' }
    specify { expect(aug4.lower_pitch).to eq 'C4' }
    specify { expect(dim5.lower_pitch).to eq 'C4' }

    specify { expect(maj3.higher_pitch).to eq 'E4' }
    specify { expect(aug4.higher_pitch).to eq 'F#4' }
    specify { expect(dim5.higher_pitch).to eq 'Gb4' }
  end

  context 'given a simple interval' do
    subject { FunctionalInterval.new('A4', 'E5') }

    its(:name) { is_expected.to eq 'perfect fifth' }
    its(:number) { is_expected.to eq 5 }
    its(:number_name) { is_expected.to eq 'fifth' }
    its(:quality) { is_expected.to eq :perfect }
    its(:shorthand) { is_expected.to eq 'P5' }
    it { is_expected.to be_simple }
    it { is_expected.not_to be_compound }

    describe 'simplification' do
      its(:simple_number) { is_expected.to eq subject.number }
      its(:simple_name) { is_expected.to eq subject.name }
    end

    describe 'inversion' do
      its(:inversion) { is_expected.to eq 'perfect fourth' }
    end
  end

  context 'given a compound interval' do
    subject { FunctionalInterval.new('E3', 'C5') }

    its(:name) { is_expected.to eq 'minor thirteenth' }
    its(:number) { is_expected.to eq 13 }
    its(:number_name) { is_expected.to eq 'thirteenth' }
    its(:quality) { is_expected.to eq 'minor' }
    its(:shorthand) { is_expected.to eq 'm13' }
    it { is_expected.not_to be_simple }
    it { is_expected.to be_compound }

    describe 'simplification' do
      its(:simple_number) { is_expected.to eq 6 }
      its(:simple_name) { is_expected.to eq 'minor sixth' }
    end

    describe 'inversion' do
      its(:inversion) { is_expected.to eq 'major third' }
    end
  end

  describe 'naming' do
    specify { expect(FunctionalInterval.new('B2', 'B4').number_name).to eq 'fifteenth' }
    specify { expect(FunctionalInterval.new('B2', 'C#5').number_name).to eq 'sixteenth' }
    specify { expect(FunctionalInterval.new('B2', 'D#5').number_name).to eq 'seventeenth' }
    specify { expect(FunctionalInterval.new('B2', 'E5').number_name).to eq '18th' }

    specify { expect(FunctionalInterval.new('B4', 'B4').name).to eq 'perfect unison' }
    specify { expect(FunctionalInterval.new('B2', 'B4').name).to eq 'perfect fifteenth' }
    specify { expect(FunctionalInterval.new('B2', 'E5').name).to eq 'two octaves and a perfect fourth' }
    specify { expect(FunctionalInterval.new('B2', 'B5').name).to eq 'three octaves' }
    specify { expect(FunctionalInterval.new('B2', 'C6').name).to eq 'three octaves and a minor second' }
    specify { expect(FunctionalInterval.new('C3', 'C#6').name).to eq 'three octaves and an augmented unison' }

    specify { expect(FunctionalInterval.new('C#4', 'Fb4').name).to eq 'doubly diminished fourth' }
    specify { expect(FunctionalInterval.new('Eb4', 'A#4').name).to eq 'doubly augmented fourth' }
    specify { expect(FunctionalInterval.new('Cb4', 'F#4').name).to eq 'doubly augmented fourth' }
  end
end