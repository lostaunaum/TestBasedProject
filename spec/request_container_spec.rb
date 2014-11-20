require_relative '../lib/puppy-breeder.rb'
require 'pry-byebug'

describe TheMill::Repos::RequestLog do
  before(:each) do
    TheMill::Repos::RequestLog.new.destroy
    TheMill::Repos::PuppyContainer.new.destroy
  end

  it "expect a new breed to have a default status of :pending" do
    result = TheMill::Request.new("Alien Dog")
    expect(result.status).to eq("pending")
  end

  it "expect to be able to add a new request" do
    request = TheMill::Request.new("Boxer")
    expect(TheMill.request_repo.add_request(request).class).to eq(Hash)
  end

  it "expect to be able to add a new request" do
    create_breed = TheMill.puppy_repo.create_new_breed("Boxer")
    puppy = TheMill::Puppy.new("Boxer", "Atlas", 60)
    add_puppy = TheMill.puppy_repo.add_puppy(puppy)
    request = TheMill::Request.new("Boxer")
    expect(TheMill.request_repo.add_request(request).class).to eq(Hash)
  end

  context "when we have many requests" do
    before(:all) do 
      TheMill::Repos::RequestLog.log << TheMill::Request.new(:boxer)
      TheMill::Repos::RequestLog.log << TheMill::Request.new(:spaniel)
      TheMill::Repos::RequestLog.log << TheMill::Request.new(:pit)
    end
  end

    it "will show approved requests" do
      request = TheMill::Request.new("Boxer", "accepted")
      TheMill.request_repo.add_request(request)
      request2 = TheMill::Request.new("Boxer", "accepted")
      TheMill.request_repo.add_request(request2)
      approved_requests = TheMill.request_repo.show_accepted_requests
      expect(approved_requests).to eq(2)
  end

  context "when puppies are not available" do
    before(:all) do
      TheMill::Repos::RequestLog.instance_variable_set :@list, []

      TheMill::Repos::PuppyContainer.create_new_breed(:boxer)
      pup = TheMill::Puppy.new(:boxer, "Atlas", 60)
      TheMill::Repos::PuppyContainer.add_puppy(pup)
      req1 = TheMill::Request.new(:boxer)
      req2 = TheMill::Request.new(:spaniel)
      TheMill::Repos::RequestLog.add_request(req1)
      TheMill::Repos::RequestLog.add_request(req2)
    end
  end

    it "will not show requests that are on hold" do
      request = TheMill::Request.new("Boxer", "pending")
      TheMill.request_repo.add_request(request)
      pending_requests = TheMill.request_repo.show_pending_requests
      expect(pending_requests.count).to eq(1)
    end
  end
