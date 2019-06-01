# frozen_string_literal: true

require 'spec_helper'

describe HeadMusic::Sonority do
  describe 'equality' do
    subject(:sonority) { described_class.new(pitch_set) }

    context 'given a major triad' do
      let(:pitch_set) { HeadMusic::PitchSet.new(%w[G4 B4 D5]) }

      it { is_expected.not_to be_nil }

      context 'compared to another sonority with a pitch set with the same pitches' do
        let(:other_pitch_set) { HeadMusic::PitchSet.new(%w[G4 B4 D5]) }
        let(:other_sonority) { described_class.new(other_pitch_set) }

        it { is_expected.to eq other_sonority }
      end

      context 'compared to a pitch set with the same pitches' do
        let(:other_pitch_set) { HeadMusic::PitchSet.new(%w[G4 B4 D5]) }

        it { is_expected.to eq other_pitch_set }
      end

      context 'compared to another sonority with a different dominant seventh chord pitch set' do
        let(:other_pitch_set) { HeadMusic::PitchSet.new(%w[C E G]) }
        let(:other_sonority) { described_class.new(other_pitch_set) }

        it { is_expected.to eq other_sonority }
      end
    end
  end

  describe '.for' do
    subject(:sonority) { described_class.new(pitch_set) }

    context 'when given a simple dyad' do
      let(:pitch_set) { HeadMusic::PitchSet.new(%w[C G]) }

      its(:identifier) { is_expected.to be_nil }
    end

    context 'when given a major triad in root position' do
      let(:pitch_set) { HeadMusic::PitchSet.new(%w[C E G]) }

      its(:identifier) { is_expected.to eq :major_triad }
      it { is_expected.to be_trichord }
      it { is_expected.to be_triad }
      it { is_expected.to be_tertian }

      its(:inversion) { is_expected.to eq 0 }
    end

    context 'when given a major triad in first inversion' do
      let(:pitch_set) { HeadMusic::PitchSet.new(%w[E G C5]) }

      its(:identifier) { is_expected.to eq :major_triad }
      it { is_expected.to be_triad }
      it { is_expected.to be_trichord }
      it { is_expected.to be_tertian }

      its(:inversion) { is_expected.to eq 1 }
    end

    context 'when given a major triad in second inversion' do
      let(:pitch_set) { HeadMusic::PitchSet.new(%w[G3 C E]) }

      its(:identifier) { is_expected.to eq :major_triad }
      it { is_expected.to be_triad }
      it { is_expected.to be_trichord }
      it { is_expected.to be_tertian }

      its(:inversion) { is_expected.to eq 2 }
    end

    context 'when given a minor triad in root position' do
      let(:pitch_set) { HeadMusic::PitchSet.new(%w[C Eb G]) }

      its(:identifier) { is_expected.to eq :minor_triad }
      it { is_expected.to be_trichord }
      it { is_expected.to be_triad }
      it { is_expected.to be_tertian }

      its(:inversion) { is_expected.to eq 0 }
    end

    context 'when given a minor triad in first inversion' do
      let(:pitch_set) { HeadMusic::PitchSet.new(%w[Eb G C5]) }

      its(:identifier) { is_expected.to eq :minor_triad }
      it { is_expected.to be_triad }
      it { is_expected.to be_trichord }
      it { is_expected.to be_tertian }

      its(:inversion) { is_expected.to eq 1 }
    end

    context 'when given a minor triad in second inversion' do
      let(:pitch_set) { HeadMusic::PitchSet.new(%w[G3 C Eb]) }

      its(:identifier) { is_expected.to eq :minor_triad }
      it { is_expected.to be_triad }
      it { is_expected.to be_trichord }
      it { is_expected.to be_tertian }

      its(:inversion) { is_expected.to eq 2 }
    end

    context 'when given a diminished triad in root position' do
      let(:pitch_set) { HeadMusic::PitchSet.new(%w[C Eb Gb]) }

      its(:identifier) { is_expected.to eq :diminished_triad }
      it { is_expected.to be_trichord }
      it { is_expected.to be_triad }
      it { is_expected.not_to be_consonant }
      it { is_expected.to be_tertian }

      its(:inversion) { is_expected.to eq 0 }
    end

    context 'when given a diminished triad in first inversion' do
      let(:pitch_set) { HeadMusic::PitchSet.new(%w[Eb Gb C5]) }

      its(:identifier) { is_expected.to eq :diminished_triad }
      it { is_expected.to be_triad }
      it { is_expected.to be_trichord }
      it { is_expected.not_to be_consonant }
      it { is_expected.to be_tertian }

      its(:inversion) { is_expected.to eq 1 }
    end

    context 'when given an diminished triad in second inversion' do
      let(:pitch_set) { HeadMusic::PitchSet.new(%w[Gb3 C Eb]) }

      its(:identifier) { is_expected.to eq :diminished_triad }
      it { is_expected.to be_triad }
      it { is_expected.to be_trichord }
      it { is_expected.not_to be_consonant }
      it { is_expected.to be_tertian }

      its(:inversion) { is_expected.to eq 2 }
    end

    context 'when given an augmented triad in root position' do
      let(:pitch_set) { HeadMusic::PitchSet.new(%w[C E G#]) }

      its(:identifier) { is_expected.to eq :augmented_triad }
      it { is_expected.to be_trichord }
      it { is_expected.to be_triad }
      it { is_expected.not_to be_consonant }
      it { is_expected.to be_tertian }

      its(:inversion) { is_expected.to eq 0 }
    end

    context 'when given an augmented triad in first inversion' do
      let(:pitch_set) { HeadMusic::PitchSet.new(%w[E G# C5]) }

      its(:identifier) { is_expected.to eq :augmented_triad }
      it { is_expected.to be_triad }
      it { is_expected.to be_trichord }
      it { is_expected.not_to be_consonant }
      it { is_expected.to be_tertian }

      its(:inversion) { is_expected.to eq 1 }
    end

    context 'when given an augmented triad in second inversion' do
      let(:pitch_set) { HeadMusic::PitchSet.new(%w[G#3 C E]) }

      its(:identifier) { is_expected.to eq :augmented_triad }
      it { is_expected.to be_triad }
      it { is_expected.to be_trichord }
      it { is_expected.not_to be_consonant }
      it { is_expected.to be_tertian }

      its(:inversion) { is_expected.to eq 2 }
    end

    context 'when given a dominant seventh chord' do
      context 'when in root position' do
        let(:pitch_set) { HeadMusic::PitchSet.new(%w[G3 B3 D F]) }

        its(:identifier) { is_expected.to eq :major_minor_seventh_chord }
        it { is_expected.to be_seventh_chord }
        it { is_expected.to be_tetrachord }
        it { is_expected.not_to be_consonant }
        it { is_expected.to be_tertian }
      end

      context 'when in first inversion' do
        let(:pitch_set) { HeadMusic::PitchSet.new(%w[B3 D F G]) }

        its(:identifier) { is_expected.to eq :major_minor_seventh_chord }
        it { is_expected.to be_seventh_chord }
        it { is_expected.to be_tetrachord }
        it { is_expected.not_to be_consonant }
        it { is_expected.to be_tertian }
      end

      context 'when in second inversion' do
        let(:pitch_set) { HeadMusic::PitchSet.new(%w[D F G B]) }

        its(:identifier) { is_expected.to eq :major_minor_seventh_chord }
        it { is_expected.to be_seventh_chord }
        it { is_expected.to be_tetrachord }
        it { is_expected.not_to be_consonant }
        it { is_expected.to be_tertian }
      end

      context 'when in third inversion' do
        let(:pitch_set) { HeadMusic::PitchSet.new(%w[F G B D5]) }

        its(:identifier) { is_expected.to eq :major_minor_seventh_chord }
        it { is_expected.to be_seventh_chord }
        it { is_expected.to be_tetrachord }
        it { is_expected.not_to be_consonant }
        it { is_expected.to be_tertian }
      end
    end

    context 'when given a major-major seventh chord' do
      context 'when in root position' do
        let(:pitch_set) { HeadMusic::PitchSet.new(%w[G3 B3 D F#]) }

        its(:identifier) { is_expected.to eq :major_major_seventh_chord }
        it { is_expected.to be_seventh_chord }
        it { is_expected.to be_tetrachord }
        it { is_expected.not_to be_consonant }
        it { is_expected.to be_tertian }
      end

      context 'when in first inversion' do
        let(:pitch_set) { HeadMusic::PitchSet.new(%w[B3 D F# G]) }

        its(:identifier) { is_expected.to eq :major_major_seventh_chord }
        it { is_expected.to be_seventh_chord }
        it { is_expected.to be_tetrachord }
        it { is_expected.not_to be_consonant }
        it { is_expected.to be_tertian }
      end

      context 'when in second inversion' do
        let(:pitch_set) { HeadMusic::PitchSet.new(%w[D F# G B]) }

        its(:identifier) { is_expected.to eq :major_major_seventh_chord }
        it { is_expected.to be_seventh_chord }
        it { is_expected.to be_tetrachord }
        it { is_expected.not_to be_consonant }
        it { is_expected.to be_tertian }
      end

      context 'when in third inversion' do
        let(:pitch_set) { HeadMusic::PitchSet.new(%w[F# G B D5]) }

        its(:identifier) { is_expected.to eq :major_major_seventh_chord }
        it { is_expected.to be_seventh_chord }
        it { is_expected.to be_tetrachord }
        it { is_expected.not_to be_consonant }
        it { is_expected.to be_tertian }
      end
    end

    context 'when given a minor seventh chord' do
      context 'when in root position' do
        let(:pitch_set) { HeadMusic::PitchSet.new(%w[G3 Bb3 D F]) }

        its(:identifier) { is_expected.to eq :minor_minor_seventh_chord }
        it { is_expected.to be_seventh_chord }
        it { is_expected.to be_tetrachord }
        it { is_expected.not_to be_consonant }
        it { is_expected.to be_tertian }
      end

      context 'when in first inversion' do
        let(:pitch_set) { HeadMusic::PitchSet.new(%w[Bb3 D F G]) }

        its(:identifier) { is_expected.to eq :minor_minor_seventh_chord }
        it { is_expected.to be_seventh_chord }
        it { is_expected.to be_tetrachord }
        it { is_expected.not_to be_consonant }
        it { is_expected.to be_tertian }
      end

      context 'when in second inversion' do
        let(:pitch_set) { HeadMusic::PitchSet.new(%w[D F G Bb]) }

        its(:identifier) { is_expected.to eq :minor_minor_seventh_chord }
        it { is_expected.to be_seventh_chord }
        it { is_expected.to be_tetrachord }
        it { is_expected.not_to be_consonant }
        it { is_expected.to be_tertian }
      end

      context 'when in third inversion' do
        let(:pitch_set) { HeadMusic::PitchSet.new(%w[F G Bb D5]) }

        its(:identifier) { is_expected.to eq :minor_minor_seventh_chord }
        it { is_expected.to be_seventh_chord }
        it { is_expected.to be_tetrachord }
        it { is_expected.not_to be_consonant }
        it { is_expected.to be_tertian }
      end
    end

    context 'when given a minor-major seventh chord' do
      context 'when in root position' do
        let(:pitch_set) { HeadMusic::PitchSet.new(%w[G3 Bb3 D F#]) }

        its(:identifier) { is_expected.to eq :minor_major_seventh_chord }
        it { is_expected.to be_seventh_chord }
        it { is_expected.to be_tetrachord }
        it { is_expected.not_to be_consonant }
        it { is_expected.to be_tertian }
      end

      context 'when in first inversion' do
        let(:pitch_set) { HeadMusic::PitchSet.new(%w[Bb3 D F# G]) }

        its(:identifier) { is_expected.to eq :minor_major_seventh_chord }
        it { is_expected.to be_seventh_chord }
        it { is_expected.to be_tetrachord }
        it { is_expected.not_to be_consonant }
        it { is_expected.to be_tertian }
      end

      context 'when in second inversion' do
        let(:pitch_set) { HeadMusic::PitchSet.new(%w[D F# G Bb]) }

        its(:identifier) { is_expected.to eq :minor_major_seventh_chord }
        it { is_expected.to be_seventh_chord }
        it { is_expected.to be_tetrachord }
        it { is_expected.not_to be_consonant }
        it { is_expected.to be_tertian }
      end

      context 'when in third inversion' do
        let(:pitch_set) { HeadMusic::PitchSet.new(%w[F# G Bb D5]) }

        its(:identifier) { is_expected.to eq :minor_major_seventh_chord }
        it { is_expected.to be_seventh_chord }
        it { is_expected.to be_tetrachord }
        it { is_expected.not_to be_consonant }
        it { is_expected.to be_tertian }
      end
    end
  end
end
