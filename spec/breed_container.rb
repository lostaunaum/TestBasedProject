require_relative '../lib/puppy-breeder.rb'
require 'pry-byebug'

describe TheMill::Repos::PuppyContainer do
  before(:each) do
    TheMill::Repos::RequestLog.new.destroy
    TheMill::Repos::PuppyContainer.new.destroy
  end
  # after(:each) do
  #   TheMill::Repos::PuppyContainer.instance_variable_set :@container, {}
  # end

  it "can show the entire puppy container" do
    expect(TheMill.puppy_repo.log_puppies).to be_a(Array)
  end
# binding.pry-byebug
  it "can add a new breed" do
    new_breed = (TheMill.puppy_repo.create_new_breed("Rotweiler", 1450))
    # TheMill.puppy_repo.create_new_breed(:boxer)
    new_breed1 = (TheMill.puppy_repo.create_new_breed("Rotweiler", 1450))
    expect(TheMill.puppy_repo.log_puppies).to_not be_nil
    expect(new_breed1).to eq("breed 'Rotweiler' already exists!")
  end

  it "will give a breed a default price" do
    new_breed_with_price = (TheMill.puppy_repo.create_new_breed("German Shepard"))
    expect(new_breed_with_price).to eq(1000)
  end

  it "can set a breed price" do
    puppy = (TheMill.puppy_repo.create_new_breed("German Shepard"))
    puppy1 = (TheMill.puppy_repo.set_breed_price("German Shepard", 500))
    expect(puppy1).to eq(500)
  end
  
  # it "can add a new puppy" do
  #   pup = TheMill::Puppy.new(:boxer, "Atlas", 60)
  #   TheMill::Repos::PuppyContainer.create_new_breed(:boxer)
  #   TheMill::Repos::PuppyContainer.add_puppy(pup)
  #   list_pup = TheMill::Repos::PuppyContainer.log[:boxer][:list].first
  #   expect(list_pup).to eq(pup)
  # end

  # context "when we have many puppies" do
  #   before(:all) do
  #     TheMill::Repos::PuppyContainer.create_new_breed(:boxer)
  #     TheMill::Repos::PuppyContainer.create_new_breed(:pit)
  #     3.times { TheMill::Repos::PuppyContainer.add_puppy(TheMill::Puppy.new(:boxer, "x", 0)) }
  #     2.times { TheMill::Repos::PuppyContainer.add_puppy(TheMill::Puppy.new(:pit, "y", 1)) }
  #   end

  #   it "can retrieve a list of puppies by breed" do
  #     boxers = TheMill::Repos::PuppyContainer.show_puppies_by_breed(:boxer)
  #     pits = TheMill::Repos::PuppyContainer.show_puppies_by_breed(:pit)
  #     expect(boxers.count).to eq(3)
  #     expect(pits.count).to eq(2)
  #   end
  # end
end
