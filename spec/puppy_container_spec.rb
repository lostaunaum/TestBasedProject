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

  it "will not set breed price if breed does not exist" do
    puppy = (TheMill.puppy_repo.create_new_breed("German Shepard"))
    puppy1 = (TheMill.puppy_repo.set_breed_price("Alien Dog", 500))
    expect(puppy1).to eq("No such breed: Alien Dog")
  end

  it "can re set breed price" do
    puppy = (TheMill.puppy_repo.create_new_breed("German Shepard"))
    puppy1 = (TheMill.puppy_repo.set_breed_price("German Shepard", 500))
    expect(puppy1).to eq(500)
  end

  it "wont add a puppy if there is not a breed created first" do

    pup = TheMill::Puppy.new("Alien Dog", "Atlas", 60)
    TheMill.puppy_repo.create_new_breed("Boxer")
    result = TheMill.puppy_repo.add_puppy(pup)
    # list_pup = TheMill::Repos::PuppyContainer.log[:boxer][:list].first
    # expect(list_pup).to eq(pup)
    expect(result).to eq("No such breed cannot create puppy object")
  end

  it "can add a new puppy" do
    pup = TheMill::Puppy.new("Boxer", "Atlas", 60)
    TheMill.puppy_repo.create_new_breed("Boxer")
    result = TheMill.puppy_repo.add_puppy(pup)
    # list_pup = TheMill::Repos::PuppyContainer.log[:boxer][:list].first
    # expect(list_pup).to eq(pup)
    expect(result["breed"]).to eq("Boxer")
    expect(result["name"]).to eq("Atlas")
    expect(result["age"]).to eq("60")
  end

    it "can retrieve a list of puppies by breed" do
      TheMill.puppy_repo.create_new_breed("Boxer")
      TheMill.puppy_repo.create_new_breed("Pit")

      pup1 = TheMill::Puppy.new("Boxer", "Atlas", 60)
      pup2 = TheMill::Puppy.new("Boxer", "Y", 60)
      pup3 = TheMill::Puppy.new("Boxer", "X", 60)
      pup4 = TheMill::Puppy.new("Pit", "Atlas", 60)
      pup5 = TheMill::Puppy.new("Pit", "Atlas", 60)

      result1 = TheMill.puppy_repo.add_puppy(pup1)
      result2 = TheMill.puppy_repo.add_puppy(pup2)
      result3 = TheMill.puppy_repo.add_puppy(pup3)
      result4 = TheMill.puppy_repo.add_puppy(pup4)
      result5 = TheMill.puppy_repo.add_puppy(pup5)

      boxers = TheMill.puppy_repo.show_puppies_by_breed("Boxer")
      pits = TheMill.puppy_repo.show_puppies_by_breed("Pit")
      expect(boxers).to eq(3)
      expect(pits).to eq(2)
    end
  end
