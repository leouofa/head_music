# frozen_string_literal: true

require 'spec_helper'

describe HeadMusic::Selection do
  let(:composition) { Composition.new }

  context 'when the composition has two voices' do
    let!(:upper_voice) { composition.add_voice(role: :melody) }
    let!(:lower_voice) { composition.add_voice(role: :bass_line) }
    let(:upper_voice_pitches) { %w[C E G A G F E D C] }
    let(:lower_voice_pitches) { %w[C3 G3 C3] }

    before do
      upper_voice.tap do |voice|
        position = "1:1:0"
        upper_voice_pitches.each do |pitch|
          voice.place(position, :quarter, pitch)
          position += :quarter
        end
      end
      lower_voice.tap do |voice|
        position = "1:1:0"
        upper_voice_pitches.each do |pitch|
          voice.place(position, :whole, pitch)
          position += :whole
        end
      end
    end

    describe 'construction' do
      let(:composition_instant) { Selection.new(composition: composition, start: '1:4') }
      let(:voice_range_with_duration) { Selection.new(voice: upper_voice, start: '2:1', duration: '1') }
      let(:voice_range_with_end) { Selection.new(voice: upper_voice, start: '2:1', end: '2:3') }

      specify do
      end
    end
  end
end
