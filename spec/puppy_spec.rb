require_relative '../lib/puppy-breeder.rb'
require 'pry-byebug'

describe TheMill::Puppy do
  let(:test_pup) { TheMill::Puppy.new(:boxer, "Atlas", 60) }

  it "has a breed" do
    expect(test_pup.breed).to eq(:boxer)
  end

  it "has a name" do
    expect(test_pup.name).to eq("Atlas")
  end

  it "has an age" do
    expect(test_pup.age).to eq(60)
  end
end
