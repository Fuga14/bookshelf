json.id @book.id
json.title @book.title
json.year @book.year
json.description @book.description
json.created_at @book.created_at
json.updated_at @book.updated_at

if @book.author
  json.author do
    json.id @book.author.id
    json.name @book.author.name
    json.bio @book.author.bio
    json.active @book.author.active
  end
else
  json.author nil
end

