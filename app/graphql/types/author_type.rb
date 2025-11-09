# frozen_string_literal: true

module Types
  class AuthorType < Types::BaseObject
    description "An author of books"

    field :id, ID, null: false
    field :name, String, null: true
    field :bio, String, null: true
    field :active, Boolean, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :books, [Types::BookType], null: true, description: "Books by this author"
  end
end

