# frozen_string_literal: true

require 'spec_helper'

describe HeadMusic::Analysis::Sonority do
  describe '.for' do
    subject(:sonority) { described_class.for(pitch_set) }

    context 'when given a simple dyad' do
      let(:pitch_set) { HeadMusic::PitchSet.new(%w[C G]) }

      it { is_expected.to be_nil }
    end

    context 'when given a major triad in root position' do
      let(:pitch_set) { HeadMusic::PitchSet.new(%w[C E G]) }

      it { is_expected.to be_a(HeadMusic::Analysis::MajorTriad) }
      it { is_expected.to be_trichord }
      it { is_expected.to be_triad }
      it { is_expected.to be_tertian }

      its(:inversion) { is_expected.to eq 0 }
    end

    context 'when given a major triad in first inversion' do
      let(:pitch_set) { HeadMusic::PitchSet.new(%w[E G C5]) }

      it { is_expected.to be_a(HeadMusic::Analysis::MajorTriad) }
      it { is_expected.to be_triad }
      it { is_expected.to be_trichord }
      it { is_expected.to be_tertian }

      its(:inversion) { is_expected.to eq 1 }
    end

    context 'when given a major triad in second inversion' do
      let(:pitch_set) { HeadMusic::PitchSet.new(%w[G3 C E]) }

      it { is_expected.to be_a(HeadMusic::Analysis::MajorTriad) }
      it { is_expected.to be_triad }
      it { is_expected.to be_trichord }
      it { is_expected.to be_tertian }

      its(:inversion) { is_expected.to eq 2 }
    end

    context 'when given a minor triad in root position' do
      let(:pitch_set) { HeadMusic::PitchSet.new(%w[C Eb G]) }

      it { is_expected.to be_a(HeadMusic::Analysis::MinorTriad) }
      it { is_expected.to be_trichord }
      it { is_expected.to be_triad }
      it { is_expected.to be_tertian }

      its(:inversion) { is_expected.to eq 0 }
    end

    context 'when given a minor triad in first inversion' do
      let(:pitch_set) { HeadMusic::PitchSet.new(%w[Eb G C5]) }

      it { is_expected.to be_a(HeadMusic::Analysis::MinorTriad) }
      it { is_expected.to be_triad }
      it { is_expected.to be_trichord }
      it { is_expected.to be_tertian }

      its(:inversion) { is_expected.to eq 1 }
    end

    context 'when given a minor triad in second inversion' do
      let(:pitch_set) { HeadMusic::PitchSet.new(%w[G3 C Eb]) }

      it { is_expected.to be_a(HeadMusic::Analysis::MinorTriad) }
      it { is_expected.to be_triad }
      it { is_expected.to be_trichord }
      it { is_expected.to be_tertian }

      its(:inversion) { is_expected.to eq 2 }
    end

    context 'when given a diminished triad in root position' do
      let(:pitch_set) { HeadMusic::PitchSet.new(%w[C Eb Gb]) }

      it { is_expected.to be_a(HeadMusic::Analysis::DiminishedTriad) }
      it { is_expected.to be_trichord }
      it { is_expected.to be_triad }
      it { is_expected.not_to be_consonant }
      it { is_expected.to be_tertian }

      its(:inversion) { is_expected.to eq 0 }
    end

    context 'when given a diminished triad in first inversion' do
      let(:pitch_set) { HeadMusic::PitchSet.new(%w[Eb Gb C5]) }

      it { is_expected.to be_a(HeadMusic::Analysis::DiminishedTriad) }
      it { is_expected.to be_triad }
      it { is_expected.to be_trichord }
      it { is_expected.not_to be_consonant }
      it { is_expected.to be_tertian }

      its(:inversion) { is_expected.to eq 1 }
    end

    context 'when given a diminished triad in second inversion' do
      let(:pitch_set) { HeadMusic::PitchSet.new(%w[Gb3 C Eb]) }

      it { is_expected.to be_a(HeadMusic::Analysis::DiminishedTriad) }
      it { is_expected.to be_triad }
      it { is_expected.to be_trichord }
      it { is_expected.not_to be_consonant }
      it { is_expected.to be_tertian }

      its(:inversion) { is_expected.to eq 2 }
    end
  end
end