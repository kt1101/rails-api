module Mutations
  module Users
    class UpdateUserMutation < BaseMutation
      null true

      # argument :user_data, Types::Data::UserData, required: true
      argument :avatar, ApolloUploadServer::Upload, required: false

      field :user, Types::Fields::UserType, null: true

      def resolve(user:, avatar:)
        # user = context[:current_user]
        # user.assign_attributes(user_data.arguments.keyword_arguments)
        # user.avatar.attach(avatar) if avatar
        # ActiveStorage::Blob::create_and_upload!(io: avatar,
        # filename: avatar.original_filename, content_type: avatar.content_type)
        # raise GraphQL::ExecutionError, user.errors.full_messages.join(', ') unless user.save

        # { user: user }
      end
    end
  end
end
