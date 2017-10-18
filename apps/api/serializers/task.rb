module Api::Serializers
  class Task < Hanami::Serializer::Base
    attribute :id,                Types::Int
    attribute :count,             Types::Int
    attribute :user_id,           Types::String
    attribute :body,              Types::String
    attribute :title,             Types::String
    attribute :lang,              Types::String
    attribute :md_body,           Types::String
    attribute :issue_url,         Types::String
    attribute :status,            Types::String
    attribute :complexity,        Types::String
    attribute :repository_name,   Types::String
    attribute :time_estimate,     Types::String
    attribute :assignee_username, Types::String
    attribute :approved,          Types::Bool
    attribute :created_at,        Types::Time
    attribute :updated_at,        Types::Time
    attribute :created_at_day,    Types::Date
  end
end
