module Mutations
  module Users
    class UpdateUserMutation < BaseMutation
      null true

      argument :user_data, Types::Data::UserData, required: true
      argument :avatar, ApolloUploadServer::Upload, required: false

      field :user, Types::Fields::UserType, null: true

      def resolve(user_data:, avatar:)
        user = context[:current_user]
        update_data = user_data.arguments.keyword_arguments
        blob = ActiveStorage::Blob.create_and_upload!(
          io: avatar,
          filename: avatar.original_filename,
          content_type: avatar.content_type
        )
        unless user.update!(avatar: blob)
          raise GraphQL::ExecutionError, user.errors.full_messages.join(', ')
        end

        unless user.update!(update_data)
          raise GraphQL::ExecutionError, user.errors.full_messages.join(', ')
        end

        { user: }
      end
    end
  end
end
