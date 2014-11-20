require 'pg'

module TheMill
  module Repos
    class PuppyContainer
      # @container = {}

      def initialize
        @db = PG.connect(host: 'localhost', dbname: 'puppy_breeder')
        destroy
      end

      def destroy
       @db.exec(%q[
         DROP TABLE IF EXISTS puppies
         ])
        @db.exec(%q[
         CREATE TABLE IF NOT EXISTS puppies(
          breed text,
          name text,
          age int)
         ])


        @db.exec(%q[
         DROP TABLE IF EXISTS breed_price
         ])
        @db.exec(%q[
         CREATE TABLE IF NOT EXISTS breed_price(
           breed text,
           price int)
         ])
      end

      def log_puppies
        puppies_result = @db.exec('SELECT * FROM puppies;')
        build_request(puppies_result.entries)
      end

      def log_breed
        breed_result = @db.exec('SELECT * FROM breed_price;')
        breed_result.map { |x| x["breed"] }.uniq
      end

      def log_breed_price
        breed_result_price = @db.exec('SELECT * FROM breed_price;')
        breed_result_price.map { |x| x["price"] }
      end

      def add_puppy(puppy)
        if !TheMill.puppy_repo.log_breed.include?(puppy.breed)
          return "No such breed cannot create puppy object"
        else 
        result = @db.exec(%q[
            INSERT INTO puppies (name, breed, age)
            VALUES ($1, $2, $3) RETURNING name, breed, age;
          ], [puppy.name, puppy.breed, puppy.age])
        result.entries.first
        end
      end

      def create_new_breed(breed, price=1000)
        return "breed '#{breed}' already exists!" if log_breed.include?(breed)

        result = @db.exec(%q[
          INSERT INTO breed_price (breed, price)
          VALUES ($1, $2)
          RETURNING price;
        ], [breed, price])
        result.entries.first["price"].to_i
      end
    
      def set_breed_price(breed, price)
        if !TheMill.puppy_repo.log_breed.include?(breed)
          return "No such breed: #{breed}"
        else
          TheMill.puppy_repo.log_breed_price.each do |x|
              x = price
              return price
          end
        end
      end
    
      def show_puppies_by_breed(pedigree)
        result = @db.exec('SELECT * FROM puppies;')
        i = 0
        array_of_breeds = result.map do |x| 
          if x["breed"] == pedigree
            i += 1
          end
        end
        return i 
      end
    
      def build_request(entries)
        entries.map do |puppies|
          x = TheMill::Repos::PuppyContainer.new(puppies["breed"])
          x.instance_variable_set :@id, puppies["id"].to_i
          x.instance_variable_set :@name, puppies["name"]
          x.instance_variable_set :@age, puppies["age"].to_i
          x
        end
      end
    end
  end 
end
