module Api::Serializers
  class User < Hanami::Serializer::Base
    attribute :id,             Types::Int
    attribute :count,          Types::Int
    attribute :name,           Types::String
    attribute :login,          Types::String
    attribute :email,          Types::String
    attribute :avatar_url,     Types::String
    attribute :bio,            Types::String
    attribute :admin,          Types::Bool
    attribute :created_at,     Types::Time
    attribute :updated_at,     Types::Time
    attribute :created_at_day, Types::Date

    attribute :tasks,    Types::Array.member(Api::Serializers::Task)
    attribute :points,   Types::Array.member(Api::Serializers::Point)
    attribute :repos,    Types::Array.member(Api::Serializers::Repo)
    attribute :accounts, Types::Array.member(Api::Serializers::Account)
  end
end
