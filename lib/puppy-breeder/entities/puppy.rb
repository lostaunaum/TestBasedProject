module TheMill
  class Puppy
    attr_accessor :breed, :name, :age
    
    def initialize(breed, name, age)
      @breed = breed
      @name = name
      @age = age
    end
  end
end
