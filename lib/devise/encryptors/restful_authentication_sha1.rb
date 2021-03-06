require "digest/sha1"

module Devise
  # Implements a way of adding different encryptions.
  # The class should implement a self.digest method that taks the following params:
  #   - password
  #   - stretches: the number of times the encryption will be applied
  #   - salt: the password salt as defined by devise
  #   - pepper: Devise config option
  #
  module Encryptors
    # = RestfulAuthenticationSha1
    # Simulates Restful Authentication's default encryption mechanism.
    # Warning: it uses Devise's pepper to port the concept of REST_AUTH_SITE_KEY
    # Warning: it uses Devise's stretches configuration to port the concept of REST_AUTH_DIGEST_STRETCHES. Should be set to 10 in 
    # the initializer to silumate the default behavior.
    class RestfulAuthenticationSha1
      
      # Gererates a default password digest based on salt, pepper and the
      # incoming password.
      def self.digest(password, stretches, salt, pepper)
        digest = pepper
        stretches.times { digest = Digest::SHA1.hexdigest([digest, salt, password, pepper].flatten.join('--')) }
        digest
      end

    end
  end
end