module APIErrors

  #
  class Error
    attr_accessor :code, :message

    def initialize(code, message)
      self.code = code
      self.message = message
    end
  end

  # Common errors
  E00000 = Error.new('E00000', 'Unexpected error')

  # Auth API
  ATH001 = Error.new('ATH001', 'Username or password is not valid')
  ATH010 = Error.new('ATH010', 'Existing user')
  ATH020 = Error.new('ATH020', 'Google: Existed email')
  ATH021 = Error.new('ATH021', 'Failed to validate ID Token')
  ATH030 = Error.new('ATH030', 'Facebook: Existed email')

  ATH090 = Error.new('ATH090', 'Username or password is not valid')
  ATH091 = Error.new('ATH091', 'Username or password is not valid')

end
