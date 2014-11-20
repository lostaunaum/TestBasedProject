require 'pg'

module TheMill
  module Repos
    class BreedRepo
      # @container = {}

      def initialize
        @db = PG.connect(host: 'localhost', dbname: 'puppy_breeder')
        build_tables
      end

      # def build_tables
      #   @db.exec(%q[
      #     CREATE TABLE IF NOT EXISTS transactions(
      #       id serial,
      #       breed text,
      #       status text
      #     )
      #   ])
      # end

      def build_tables
       @db.exec(%q[
         DROP TABLE IF EXISTS breed_price
         ])
        @db.exec(%q[
         CREATE TABLE IF NOT EXISTS breed_price(
           breed text,
           price int)
         ])
      end

      def breeds
        result = @db.exec('SELECT * FROM breed_price;')
        build_request(result.entries)
      end

      def add_breed(breed, price)
      if !TheMill.puppy_repo.log_puppy.breed.include?(puppy.breed)
        return "no such breed"
        if 
          @db.exec(%q[
            INSERT INTO breed_price (breed, price)
            VALUES ($1, $2);
          ], [breed, price])
          end
        end
      end

      def change_breed_price(price, new_price)
          @db.exec(%q[
            UPDATE breeds SET price = $1 WHERE breed = $2
            VALUES ($1, $2);
          ], [price, new_price])
      end
    
      def set_breed_price(breed, price)
        if !TheMill.puppy_repo.log_breed.include?(breed)
          return "No such breed: #{breed}"
        else
          TheMill.puppy_repo.log_breed
        end
      end
    
      def show_puppies_by_breed(breed)
      #   @container[breed][:list]

          result = @db.exec(%q[
          SELECT * FROM puppies WHERE breed = breed;
        ])
        build_request(result.entries)
      end
    
  #    def remove_a_puppy(breed)
  #      @container[breed][:list].shift
  #    end
      def build_request(entries)
        entries.map do |puppies|
          x = TheMill::Repo::BreedRepo.new(puppies["breed"], breed["price"].to_i)
          x
        end
      end
    end
  end 
end
