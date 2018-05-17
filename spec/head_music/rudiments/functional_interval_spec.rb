# frozen_string_literal: true

require 'spec_helper'

describe HeadMusic::FunctionalInterval do
  describe '.get' do
    let(:maj3) { described_class.get(:major_third) }
    let(:aug4) { described_class.get(:augmented_fourth) }
    let(:dim5) { described_class.get('diminished fifth') }

    describe 'default position' do
      specify { expect(maj3.lower_pitch).to eq 'C4' }
      specify { expect(aug4.lower_pitch).to eq 'C4' }
      specify { expect(dim5.lower_pitch).to eq 'C4' }

      specify { expect(maj3.higher_pitch).to eq 'E4' }
      specify { expect(aug4.higher_pitch).to eq 'F#4' }
      specify { expect(dim5.higher_pitch).to eq 'Gb4' }
    end
  end

  describe 'predicate methods' do
    context 'given a perfect unison' do
      let(:unison) { described_class.get(:perfect_unison) }

      specify { expect(unison).to be_perfect }
      specify { expect(unison).not_to be_major }
      specify { expect(unison).not_to be_minor }
      specify { expect(unison).not_to be_diminished }
      specify { expect(unison).not_to be_doubly_diminished }
      specify { expect(unison).not_to be_augmented }
      specify { expect(unison).not_to be_doubly_augmented }

      specify { expect(unison).to be_unison }
      specify { expect(unison).not_to be_second }
      specify { expect(unison).not_to be_third }
      specify { expect(unison).not_to be_fourth }
      specify { expect(unison).not_to be_fifth }
      specify { expect(unison).not_to be_sixth }
      specify { expect(unison).not_to be_seventh }
      specify { expect(unison).not_to be_octave }

      specify { expect(unison).not_to be_step }
      specify { expect(unison).not_to be_skip }
      specify { expect(unison).not_to be_leap }
      specify { expect(unison).not_to be_large_leap }
    end

    context 'given a major third' do
      let(:maj3) { described_class.get(:major_third) }

      specify { expect(maj3).not_to be_perfect }
      specify { expect(maj3).to be_major }
      specify { expect(maj3).not_to be_minor }
      specify { expect(maj3).not_to be_diminished }
      specify { expect(maj3).not_to be_doubly_diminished }
      specify { expect(maj3).not_to be_augmented }
      specify { expect(maj3).not_to be_doubly_augmented }

      specify { expect(maj3).not_to be_unison }
      specify { expect(maj3).not_to be_second }
      specify { expect(maj3).to be_third }
      specify { expect(maj3).not_to be_fourth }
      specify { expect(maj3).not_to be_fifth }
      specify { expect(maj3).not_to be_sixth }
      specify { expect(maj3).not_to be_seventh }
      specify { expect(maj3).not_to be_octave }

      specify { expect(maj3).not_to be_step }
      specify { expect(maj3).to be_skip }
      specify { expect(maj3).to be_leap }
      specify { expect(maj3).not_to be_large_leap }
    end
  end

  describe 'comparison' do
    let!(:maj3) { described_class.get(:major_third) }
    let!(:min3) { described_class.get(:minor_third) }
    let(:perfect5) { described_class.get(:perfect_fifth) }

    specify { expect(maj3).to be > min3 }
    specify { expect(min3).to be < maj3 }
    specify { expect(perfect5).to be > maj3 }
  end

  context 'given two pitches comprising a simple interval' do
    subject { described_class.new('A4', 'E5') }

    its(:name) { is_expected.to eq 'perfect fifth' }
    its(:number) { is_expected.to eq 5 }
    its(:number_name) { is_expected.to eq 'fifth' }
    its(:quality) { is_expected.to eq :perfect }
    its(:shorthand) { is_expected.to eq 'P5' }
    it { is_expected.to be_simple }
    it { is_expected.not_to be_compound }

    it { is_expected.not_to be_step }
    it { is_expected.not_to be_skip }
    it { is_expected.to be_leap }
    it { is_expected.to be_large_leap }

    describe 'simplification' do
      its(:simple_number) { is_expected.to eq subject.number }
      its(:simple_name) { is_expected.to eq subject.name }
    end

    describe 'inversion' do
      its(:inversion) { is_expected.to eq 'perfect fourth' }
    end
  end

  context 'given a compound interval' do
    subject { described_class.new('E3', 'C5') }

    its(:name) { is_expected.to eq 'minor thirteenth' }
    its(:number) { is_expected.to eq 13 }
    its(:number_name) { is_expected.to eq 'thirteenth' }
    its(:quality) { is_expected.to eq 'minor' }
    its(:shorthand) { is_expected.to eq 'm13' }
    it { is_expected.not_to be_simple }
    it { is_expected.to be_compound }
    it { is_expected.to be_imperfect_consonance }
    it { is_expected.to be_consonance }

    describe 'simplification' do
      its(:simple_number) { is_expected.to eq 6 }
      its(:simple_name) { is_expected.to eq 'minor sixth' }
      it { is_expected.not_to be_sixth }
      it { is_expected.to be_sixth_or_compound }
    end

    describe 'inversion' do
      its(:inversion) { is_expected.to eq 'major third' }
    end
  end

  describe 'naming' do
    specify { expect(described_class.new('B2', 'B4').number_name).to eq 'fifteenth' }
    specify { expect(described_class.new('B2', 'C#5').number_name).to eq 'sixteenth' }
    specify { expect(described_class.new('B2', 'D#5').number_name).to eq 'seventeenth' }
    specify { expect(described_class.new('B2', 'E5').number_name).to eq '18th' }

    specify { expect(described_class.new('B4', 'B4').name).to eq 'perfect unison' }
    specify { expect(described_class.new('B2', 'B4').name).to eq 'perfect fifteenth' }
    specify { expect(described_class.new('B2', 'E5').name).to eq 'two octaves and a perfect fourth' }
    specify { expect(described_class.new('B2', 'B5').name).to eq 'three octaves' }
    specify { expect(described_class.new('B2', 'C6').name).to eq 'three octaves and a minor second' }
    specify { expect(described_class.new('C3', 'C#6').name).to eq 'three octaves and an augmented unison' }

    specify { expect(described_class.new('C#4', 'Fb4').name).to eq 'doubly diminished fourth' }
    specify { expect(described_class.new('Eb4', 'A#4').name).to eq 'doubly augmented fourth' }
    specify { expect(described_class.new('Cb4', 'F#4').name).to eq 'doubly augmented fourth' }
  end

  describe 'consonance' do
    specify { expect(described_class.get(:minor_second).consonance).to be_dissonant }
    specify { expect(described_class.get(:major_second).consonance).to be_dissonant }
    specify { expect(described_class.get(:minor_third).consonance).to be_imperfect }
    specify { expect(described_class.get(:major_third).consonance).to be_imperfect }
    specify { expect(described_class.get(:perfect_fourth).consonance).to be_perfect }
    specify { expect(described_class.get(:perfect_fourth).consonance(:two_part_harmony)).to be_dissonant }
    specify { expect(described_class.get(:perfect_eleventh).consonance(:two_part_harmony)).to be_dissonant }
    specify { expect(described_class.get(:augmented_fourth).consonance).to be_dissonant }
    specify { expect(described_class.get(:diminished_fifth).consonance).to be_dissonant }
    specify { expect(described_class.get(:perfect_fifth).consonance).to be_perfect }
    specify { expect(described_class.get(:minor_sixth).consonance).to be_imperfect }
    specify { expect(described_class.get(:major_sixth).consonance).to be_imperfect }
    specify { expect(described_class.get(:minor_seventh).consonance).to be_dissonant }
    specify { expect(described_class.get(:major_seventh).consonance).to be_dissonant }
    specify { expect(described_class.get(:perfect_octave).consonance).to be_perfect }
  end
end