#FOR SOME REASON THE TABLE REQUESTS KEEPS GETTING DELATED
require 'pg'

module TheMill
  module Repos
    class RequestLog
      #@list = []

      def initialize
        @db = PG.connect(host: 'localhost', dbname: 'puppy_breeder')
        destroy
      end

      def destroy
        @db.exec(%q[
         DROP TABLE IF EXISTS requests
         ])
        @db.exec(%q[
          CREATE TABLE IF NOT EXISTS requests(
            id serial,
            breed text,
            status text
          )
        ])
      end

      # def destroy
      #  @db.exec(%q[
      #    DROP TABLE IF EXISTS requests
      #    ])
      # end

      def log_puppies
        puppies_result = @db.exec('SELECT * FROM puppies;')
        build_request(puppies_result.entries)
      end

      def log_transactions
        result = @db.exec('SELECT * FROM requests;')
        build_request(result.entries)
      end
    
      def add_request(request)
        result = @db.exec(%q[
          INSERT INTO requests (breed, status)
          VALUES ($1, $2) RETURNING breed, status;
        ], [request.breed, request.status])
        result.entries.first
      end
    
      def show_pending_requests      
        result = @db.exec(%q[
          SELECT * FROM requests WHERE status = 'pending';
        ])
        build_request(result.entries)
      end
  
      def show_accepted_requests
        result = @db.exec(%q[
          SELECT * FROM requests WHERE status = 'accepted';
        ])
        return build_request(result.entries).length
        # accepted = 0
        # array_of_accepted_transactions = result.map do |x| 
        #   if x["status"] == "accepted"
        #     accepted += 1
        #   end
        # end
        # return accepted
        # @list.select { |r| r.accepted? }

        # result = @db.exec(%q[
        #   SELECT * FROM requests WHERE status = 'accepted';
        # ])
        # return result
        # build_request(result.entries)
      end

      def build_request(entries)
        entries.map do |req|
          x = TheMill::Request.new(req["breed"])
          x.instance_variable_set :@id, req["id"].to_i
          x.instance_variable_set :@status, req["status"].to_sym
          x
        end
      end
    end
  end
end
