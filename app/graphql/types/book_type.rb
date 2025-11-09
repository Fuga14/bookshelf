# frozen_string_literal: true

module Types
  class BookType < Types::BaseObject
    description "A book in the library"

    field :id, ID, null: false
    field :title, String, null: false
    field :author, String, null: true, description: "Author name as string"
    field :year, Integer, null: true
    field :description, String, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :author_record, Types::AuthorType, null: true, description: "Author record if associated", method: :author
  end
end

