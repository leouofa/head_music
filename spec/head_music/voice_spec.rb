require 'spec_helper'

describe Voice do
  let(:composition) { Composition.new(name: 'Invention') }

  subject(:voice) { Voice.new(composition: composition) }

  its(:composition) { is_expected.to eq composition }

  describe '#place' do
    it 'adds a placement' do
      position = Position.new(composition, "5:1:0")
      expect {
        voice.place(position, :quarter)
      }.to change {
        voice.placements.length
      }.by 1
    end

    describe 'sorting' do
      let!(:placement1) { voice.place(Position.new(composition, "5:1:0"), :quarter) }
      let!(:placement2) { voice.place(Position.new(composition, "4:3:0"), :quarter) }

      it 'sorts by position' do
        expect(voice.placements).to eq [placement2, placement1]
      end
    end
  end

  describe '#notes' do
    let!(:note1) { voice.place(Position.new(composition, "1:1:0"), :quarter, 'D') }
    let!(:rest) { voice.place(Position.new(composition, "1:2:0"), :quarter) }
    let!(:note2) { voice.place(Position.new(composition, "1:3:0"), :quarter, 'G') }

    before do
      expect(note1).to be_note
    end

    its(:notes) { are_expected.to eq [note1, note2] }
  end

  describe 'role' do
    subject(:voice) { Voice.new(composition: composition, role: 'Cantus Firmus') }

    its(:role) { is_expected.to eq 'Cantus Firmus' }
  end
end