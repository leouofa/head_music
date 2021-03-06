# frozen_string_literal: true

require 'spec_helper'

describe HeadMusic::IntervalCycle do
  describe 'construction' do
    context 'when given a diatonic interval' do
      let(:minor_third) { HeadMusic::DiatonicInterval.get(:minor_third) }

      subject(:diminished_seventh_sonority) { described_class.new(interval: :minor_third) }

      its(:interval) { is_expected.to eq minor_third }

      describe '#pitches' do
        it 'returns a list of pitches until the first repeated pitch class' do
          expect(diminished_seventh_sonority.pitches.map(&:to_s)).to eq(%w[C4 E♭4 G♭4 B𝄫4])
        end
      end

      describe '#pitch_class_set' do
        it 'returns a list of pitches until the first repeated pitch class' do
          expect(diminished_seventh_sonority.pitch_class_set).to eq HeadMusic::PitchClassSet.new(%w[C Eb Gb Bbb])
        end
      end
    end

    context 'when given a number of steps as the interval' do
      subject(:diminished_seventh_sonority) { described_class.new(interval: 3) }

      its(:interval) { is_expected.to eq HeadMusic::ChromaticInterval.get(3) }

      describe '#pitches' do
        it 'returns a list of pitches before the first repeated pitch class' do
          expect(diminished_seventh_sonority.pitches.map(&:to_s)).to eq(%w[C4 D♯4 F♯4 A4])
        end
      end

      describe '#pitch_class_set' do
        it 'returns a list of pitches until the first repeated pitch class' do
          expect(diminished_seventh_sonority.pitch_class_set).to eq HeadMusic::PitchClassSet.new(%w[C Eb Gb Bbb])
        end
      end
    end

    context 'when specifying a starting pitch' do
      let(:major_third) { HeadMusic::DiatonicInterval.get(:major_third) }

      subject(:augmented_triad_sonority) do
        described_class.new(interval: :major_third, starting_pitch: 'Ab3')
      end

      describe '#pitches' do
        it 'returns a list of pitches until the first repeated pitch class' do
          expect(subject.pitches.map(&:to_s)).to eq(%w[A♭3 C4 E4])
        end
      end
    end
  end

  describe '.get' do
    context 'when the identifier is a named cycle' do
      let(:c0) { described_class.get('C0') }
      let(:c1) { described_class.get('C1') }
      let(:c2) { described_class.get('C2') }
      let(:c3) { described_class.get('C3') }
      let(:c4) { described_class.get('C4') }
      let(:c5) { described_class.get('C5') }
      let(:c6) { described_class.get('C6') }
      let(:c7) { described_class.get('C7') }
      let(:c8) { described_class.get('C8') }
      let(:c9) { described_class.get('C9') }
      let(:c10) { described_class.get('C10') }
      let(:c11) { described_class.get('C11') }

      specify { expect(c0.pitches.length).to eq 1 }
      specify { expect(c1.pitches.length).to eq 12 }
      specify { expect(c2.pitches.length).to eq 6 }
      specify { expect(c3.pitches.length).to eq 4 }
      specify { expect(c4.pitches.length).to eq 3 }
      specify { expect(c5.pitches.length).to eq 12 }
      specify { expect(c6.pitches.length).to eq 2 }
      specify { expect(c7.pitches.length).to eq 12 }
      specify { expect(c8.pitches.length).to eq 3 }
      specify { expect(c9.pitches.length).to eq 4 }
      specify { expect(c10.pitches.length).to eq 6 }
      specify { expect(c11.pitches.length).to eq 12 }
    end

    context 'when the identifier is an integer' do
      specify { expect(described_class.get(6).pitches.length).to eq 2 }
    end
  end
end
