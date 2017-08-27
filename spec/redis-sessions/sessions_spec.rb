require "spec_helper"

RSpec.describe Grape::RedisSessions do
  it "has a version number" do
    expect(Grape::RedisSessions::VERSION).not_to be nil
  end
end
