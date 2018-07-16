
class Client
  include HTTParty
  base_uri "https://requestb.in"
  attr_accessor :api_response, :api_errors
 
  def initialize(csv_url)
    post_created_csv(csv_url)
  end

  def post_created_csv(csv_url)

    handle_client do
      @api_response = self.class.post('/14rl2ir1', {body:  "#{csv_url}"} )
    end
  end 

  private

  def handle_client 
    begin
      yield
    rescue Net::OpenTimeout, StandardError => e
        @api_errors = e
    else
      self
    end
  end

end


