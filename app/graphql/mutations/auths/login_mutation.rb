module Mutations
  module Auths
    class LoginMutation < Mutations::BaseMutation
      null true

      argument :email, String, required: true
      argument :password, String, required: true

      field :user, Types::Fields::UserType, null: true
      field :token, String, null: true

      def resolve(email: nil, password: nil)
        raise GraphQL::ExecutionError, 'Email/Password cant empty' unless email && password

        user = User.find_by(email:)
        raise GraphQL::ExecutionError, 'Invalid email or password' if user.nil?

        unless user.authenticate(password)
          raise GraphQL::ExecutionError,
                'Invalid email or password'
        end

        token = encode_token(user.id)
        UserToken.create!(token:, user_id: user.id)
        { user:, token: "Bearer #{token}" }
      end

      private

      def encode_token(id)
        payload = {
          user_id: id,
          exp: Time.now.to_i + 3600
        }
        JWT.encode(payload, 'my_secret')
      end
    end
  end
end
