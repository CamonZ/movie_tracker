require "#{Dir.pwd}/spec/support/request_helpers.rb"

include RequestHelpers::JSON
schema_directory = "#{Dir.pwd}/spec/support/api/schemas"

RSpec::Matchers.define :be_a_serialized_collection_of do |schema_name|
  match do |response|
    schema = JSON.parse(File.read("#{schema_directory}/#{schema_name.to_s.singularize}.json"))
    result = ::JSON::Validator.validate!(schema, parsed_response[schema_name], strict: true, list: true)


    if required_length
      result &= parsed_response[schema_name].length == required_length
    end

    result
  end

  chain :of_length, :required_length
end

RSpec::Matchers.define :be_a_serialized do |schema_name| 
  match do |response|
    schema = JSON.parse(File.read("#{schema_directory}/#{schema_name}.json"))
    response_object = parsed_response[schema_name]

    result = ::JSON::Validator.validate!(schema, response_object, strict: true)


    if expected_attributes
      expected_attributes.each_pair do |key, value|
        result &= response_object[key] == value
      end
    end

    if child_collection_name
      if result &= response_object.has_key?(child_collection_name)
        if @check_for_empty
          result &= response_object[child_collection_name] == []
        else
          result &= response_object[child_collection_name].any? { |c| c == child_member_attributes }
        end
      end
    end

    result
 end

  chain :with_attributes, :expected_attributes
  chain :with_a_collection_of, :child_collection_name
  chain :that_includes, :child_member_attributes
  chain :that_is_empty do
    @check_for_empty = true
  end
end


