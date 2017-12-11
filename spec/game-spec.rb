require 'game'

describe Game do
  let(:name) { double(:name) }
  let(:player) { double(:player, name: name) }
  subject(:game) { described_class.new(player) }

  it { is_expected.to respond_to(:player_name) }

  it "can get the players name" do
    expect(game.player_name).to eq name
  end
end
