# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Clear existing books
Book.destroy_all

# Create sample books
books = [
  {
    title: "The Great Gatsby",
    author: "F. Scott Fitzgerald",
    year: 1925,
    description: "A classic American novel set in the Jazz Age, following the mysterious millionaire Jay Gatsby and his obsession with Daisy Buchanan."
  },
  {
    title: "1984",
    author: "George Orwell",
    year: 1949,
    description: "A dystopian social science fiction novel about totalitarian surveillance and thought control in a future society."
  },
  {
    title: "To Kill a Mockingbird",
    author: "Harper Lee",
    year: 1960,
    description: "A coming-of-age story dealing with racial inequality and loss of innocence in the American South."
  },
  {
    title: "One Hundred Years of Solitude",
    author: "Gabriel García Márquez",
    year: 1967,
    description: "A magical realist novel that tells the multi-generational story of the Buendía family in the fictional town of Macondo."
  },
  {
    title: "The Catcher in the Rye",
    author: "J.D. Salinger",
    year: 1951,
    description: "A controversial novel about teenage rebellion and alienation, told from the perspective of Holden Caulfield."
  },
  {
    title: "Lord of the Flies",
    author: "William Golding",
    year: 1954,
    description: "A story about a group of British boys stranded on an uninhabited island and their disastrous attempt to govern themselves."
  },
  {
    title: "The Hobbit",
    author: "J.R.R. Tolkien",
    year: 1937,
    description: "A fantasy novel about the adventures of Bilbo Baggins, a hobbit who goes on an unexpected journey to help dwarves reclaim their homeland."
  }
]

books.each do |book_attrs|
  Book.create!(book_attrs)
end

puts "Created #{Book.count} books successfully!"
