module TheMill
  class Request
    attr_reader :breed
    attr_reader :status
  
    def initialize(breed, status = "pending")
      @breed = breed
      @status = status
    end

    def activate!
      @status = "pending"
    end

    def pending?
      @status == "pending"
    end
  
    def accept!
      @status = "acepted"
    end

    def accepted?
      @status == "acepted"
    end

    def hold!
      @status = "on_hold"
    end

    def on_hold?
      @status == "on_hold"
    end
  end
end
