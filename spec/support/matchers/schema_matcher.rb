require "#{Dir.pwd}/spec/support/request_helpers.rb"

include RequestHelpers::JSON
schema_directory = "#{Dir.pwd}/spec/support/api/schemas"

RSpec::Matchers.define :be_a_serialized_collection_of do |schema_name|
  match do |response|
    schema = JSON.parse(File.read("#{schema_directory}/#{schema_name.to_s.singularize}.json"))
    ::JSON::Validator.validate!(schema, parsed_response[schema_name], strict: true, list: true)
  end
end

RSpec::Matchers.define :be_a_serialized do |schema_name| 
  match do |response|
    schema = JSON.parse(File.read("#{schema_directory}/#{schema_name}.json"))

    result = ::JSON::Validator.validate!(schema, parsed_response[schema_name], strict: true)


    if expected_attributes
      expected_attributes.each_pair do |key, value|
        result &= parsed_response[schema_name][key] == value
      end
    end
    result
 end

  chain :with_attributes, :expected_attributes
end


