require 'spec_helper'

describe Dare::Window do
  let(:canvas) {double()}
  let(:clock) {double()}
  let(:window_without_defaults) {Dare::Window.new(clock: clock, canvas: canvas, no_mouse: true)}
  let(:window_with_defaults) {Dare::Window.new(width: 200, height: 100, clock: clock, canvas: canvas, no_mouse: true)}
  before do
    allow(canvas).to receive(:context)
    allow(canvas).to receive(:id)
    allow(canvas).to receive(:canvas)
    allow(clock).to receive(:start)
  end
  it "has a default width" do
    expect(window_without_defaults.width).to eq 640
  end
  it "has a default height" do
    expect(window_without_defaults.height).to eq 480
  end
  it "can be passed a width" do
    expect(window_with_defaults.width).to eq 200
  end
  it "can be passed a height" do
    expect(window_with_defaults.height).to eq 100
  end
  describe "#update" do
    it "runs once per update interval" do
      #window = Dare::Window.new(update_interval: 16.666)
      #window.run!
      #sleep 0.5
      #window.stop!
      #expect(window.ticks).to be > 10
    end
  end
  describe "#draw" do
    it "is run after each update" do

    end
  end
end
