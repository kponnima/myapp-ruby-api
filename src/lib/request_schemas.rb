# frozen_string_literal: true

# require 'json-schema'

module SupportServices
  module Schemas
    AUTHENTICATE_USER = {
      'id' => 'authenticateUserRequest',
      'type' => 'object',
      'required' => ['username', 'password'],
      'properties' => {
        'username' => { 'type' => 'string', 'minLength': 1, 'maxLength': 20 },
        'password' => { 'type' => 'string', 'minLength': 8, 'maxLength': 20 }
      }
    }.freeze
  end
end
