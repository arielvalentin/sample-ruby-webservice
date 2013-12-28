module Example
  module Client
    class AccountsGateway

      DefaultHeaders = {'Content-Type' => 'application/json'}

      def initialize(args={})
        @base_uri = args.fetch(:base_uri, 'http://localhost:9292')
        @http_client = HTTPClient.new
      end
      
      def create(account_params)
        response = http_client.post('http://www.example.com/', account_params.to_json, {'Content-Type' => 'application/json'})
        Account.new(JSON.parse(response.body, symbolize_names: true))
      end
      
      def find_by_number(number)
        response = http_client.get("#{base_uri}/#{number}")
        Account.new(JSON.parse(response.body, symbolize_names: true))
      end

      private 
      attr_reader :base_uri, :http_client
    end
  end
end
