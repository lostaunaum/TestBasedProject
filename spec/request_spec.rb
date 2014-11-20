require_relative '../lib/puppy-breeder.rb'
require 'pry-byebug'

describe TheMill::Request do
  let(:test_request) { TheMill::Request.new(:boxer) }
  
  it "has a breed" do
    expect(test_request.breed).to eq(:boxer)
  end

  it "is not approved by default" do
    expect(test_request.accepted?).to be false
  end

  it "can be approved" do
    test_request.accept!
    expect(test_request.accepted?).to be true
  end
end
