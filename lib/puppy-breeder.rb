module TheMill
  # setter method for request repo
  def self.request_repo=(x)
    @request_repo = x
  end

  # getter method for request repo
  def self.request_repo
    @request_repo
  end

  def self.puppy_repo=(x)
    @puppy_repo = x
  end

  def self.puppy_repo
    @puppy_repo
  end

  def self.breed_repo=(x)
    @breed_repo = x
  end
  def self.breed_repo
    @breed_repo
  end

end

require_relative 'puppy-breeder/entities/puppy.rb'
require_relative 'puppy-breeder/entities/request.rb'
require_relative 'puppy-breeder/entities/breed.rb'
require_relative 'puppy-breeder/databases/puppy_repo.rb'
require_relative 'puppy-breeder/databases/request_repo.rb'
require_relative 'puppy-breeder/databases/breed_repo.rb'


TheMill.request_repo = TheMill::Repos::RequestLog.new
TheMill.puppy_repo = TheMill::Repos::PuppyContainer.new
TheMill.breed_repo = TheMill::Repos::BreedRepo.new

