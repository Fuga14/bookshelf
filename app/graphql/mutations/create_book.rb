# frozen_string_literal: true

module Mutations
  class CreateBook < BaseMutation
    description "Creates a new book"

    argument :title, String, required: true, description: "Title of the book"
    argument :author, String, required: true, description: "Author name"
    argument :year, Integer, required: true, description: "Publication year"

    field :book, Types::BookType, null: true, description: "The created book"
    field :errors, [String], null: false, description: "List of errors if creation failed"

    def resolve(title:, author:, year:)
      book = Book.new(title: title, year: year)
      book[:author] = author  # Use string field, not association

      if book.save
        {
          book: book,
          errors: []
        }
      else
        {
          book: nil,
          errors: book.errors.full_messages
        }
      end
    end
  end
end

