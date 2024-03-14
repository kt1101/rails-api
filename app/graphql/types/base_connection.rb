module Types
  class BaseConnection < Types::BaseObject
    # add `nodes` & `pageInfo` fields, as well as `edge_type(...)` & `node_nullable(...)` overrides
    include GraphQL::Types::Relay::ConnectionBehaviors
  end
end
