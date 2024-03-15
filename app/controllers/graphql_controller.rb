class GraphqlController < ApplicationController
  # If accessing from outside this domain, nullify the session
  # This allows for outside API access while preventing CSRF attacks,
  # but you'll have to authenticate your user separately
  # protect_from_forgery with: :null_session
  skip_before_action :authenticated, if: :skips_authentication

  OPERATION_NAME_SKIP_AUTHENTICATION = %w[loginMutation signupMutation shareLinkMutation
                                          createApplicantMutation].freeze

  def execute
    variables = prepare_variables(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    context = {
      # Query context goes here, for example:
      current_user:,
      token: logged_in_token || ''
    }
    result = RailsApiSchema.execute(query, variables:, context:,
                                           operation_name:)

    render json: result
    # rescue StandardError => e
    #   raise e unless Rails.env.development?

    #   handle_error_in_development(e)
  end

  private

  def skips_authentication
    query_parse = GraphQL::Query.new(RailsApiSchema, params[:query])
    current_operation_name = query_parse.selected_operation.selections[0].name

    OPERATION_NAME_SKIP_AUTHENTICATION.include?(current_operation_name)
  end

  # Handle variables in form data, JSON body, or a blank value
  def prepare_variables(variables_param)
    case variables_param
    when String
      if variables_param.present?
        JSON.parse(variables_param) || {}
      else
        {}
      end
    when Hash
      variables_param
    when ActionController::Parameters
      # GraphQL-Ruby will validate name and type of incoming variables.
      variables_param.to_unsafe_hash
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{variables_param}"
    end
  end

  def handle_error_in_development(err)
    logger.error(err.message)
    logger.error(err.backtrace.join("\n"))

    render json: { errors: [{ message: err.message, backtrace: err.backtrace }], data: {} },
           status: :internal_server_error
  end
end
