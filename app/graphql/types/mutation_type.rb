# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_book, mutation: Mutations::CreateBook,
      description: "Creates a new book"
  end
end
