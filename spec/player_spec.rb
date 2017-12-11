require 'player'

describe Player do
  subject(:player) { described_class.new(name) }
  let(:name) { double(:name) }
  it { is_expected.to respond_to(:name) }

  it 'stores a name' do
    expect(player.name).to eq name
  end
end
