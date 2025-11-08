# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Clear existing data
Book.destroy_all
Author.destroy_all

# Create authors
author1 = Author.create!(
  name: "F. Scott Fitzgerald",
  bio: "American novelist, essayist, and short story writer, best known for his novel The Great Gatsby.",
  active: true
)

author2 = Author.create!(
  name: "George Orwell",
  bio: "English novelist, essayist, journalist, and critic, known for his dystopian novel 1984 and allegorical novella Animal Farm.",
  active: true
)

author3 = Author.create!(
  name: "Harper Lee",
  bio: "American novelist best known for her 1960 novel To Kill a Mockingbird, which won the Pulitzer Prize.",
  active: false
)

# Create books for active authors
Book.create!(
  title: "The Great Gatsby",
  author: author1,
  year: 1925,
  description: "A classic American novel set in the Jazz Age, following the mysterious millionaire Jay Gatsby and his obsession with Daisy Buchanan."
)

Book.create!(
  title: "This Side of Paradise",
  author: author1,
  year: 1920,
  description: "F. Scott Fitzgerald's debut novel about Amory Blaine, a young man from the Midwest who attends Princeton University."
)

Book.create!(
  title: "Tender Is the Night",
  author: author1,
  year: 1934,
  description: "A novel about the rise and fall of Dick Diver, a promising young psychoanalyst and his wife Nicole."
)

Book.create!(
  title: "1984",
  author: author2,
  year: 1949,
  description: "A dystopian social science fiction novel about totalitarian surveillance and thought control in a future society."
)

Book.create!(
  title: "Animal Farm",
  author: author2,
  year: 1945,
  description: "An allegorical novella about a group of farm animals who rebel against their human farmer, hoping to create a society where the animals can be equal, free, and happy."
)

Book.create!(
  title: "Homage to Catalonia",
  author: author2,
  year: 1938,
  description: "A personal account of Orwell's experiences and observations fighting in the Spanish Civil War."
)

puts "Created #{Author.count} authors and #{Book.count} books successfully!"
