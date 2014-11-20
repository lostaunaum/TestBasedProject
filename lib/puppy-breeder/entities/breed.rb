require 'pry-byebug'

module TheMill
  class BreedRepo
    attr_accessor :breed, :price
    def initialize(breed, price)
      @breed = breed
      @price = price
    end
  end
end
