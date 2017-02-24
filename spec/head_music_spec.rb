require "spec_helper"

describe HeadMusic do
  it "has a three-digit version number" do
    expect(HeadMusic::VERSION).not_to be nil
    expect(HeadMusic::VERSION).to be =~ /\d+\.\d+\.\d+/
  end
end
