require 'spec_helper'

describe HeadMusic::Style::Rules::RecoverLeaps do
  let(:composition) { Composition.new(name: "Majestic D", key_signature: 'D dorian') }
  let(:voice) { Voice.new(composition: composition) }
  let(:rule) { described_class }
  subject(:annotation) { rule.analyze(voice) }

  context 'with no notes' do
    its(:fitness) { is_expected.to eq 1 }
  end

  context 'with leaps' do
    context 'recovered by step in the opposite direction' do
      before do
        %w[D4 F4 E4 D4 G4 F4 A4 G4 F4 E4 D4].each_with_index do |pitch, bar|
          voice.place("#{bar + 1}:1", :whole, pitch)
        end
      end

      its(:fitness) { is_expected.to eq 1 }
    end

    context 'recovered by skip in the opposite direction' do
      before do
        %w[D4 F4 E4 D4 G4 E4 A4 G4 F4 E4 D4].each_with_index do |pitch, bar|
          voice.place("#{bar + 1}:1", :whole, pitch)
        end
      end

      its(:fitness) { is_expected.to be < 1 }
      its(:fitness) { is_expected.to be > 0 }
    end

    context 'not recovered' do
      before do
        %w[D4 F4 E4 D4 G4 B4 G4 F4 E4 D4].each_with_index do |pitch, bar|
          voice.place("#{bar + 1}:1", :whole, pitch)
        end
      end

      its(:fitness) { is_expected.to be < GOLDEN_RATIO_INVERSE }
      its(:fitness) { is_expected.to be > 0 }
    end
  end
end
