module RequestHelpers
  module JSON
    def parsed_response
      ::JSON.parse(response.body).deep_symbolize_keys
    end
  end
end
