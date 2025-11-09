json.books @books do |book|
  json.id book.id
  json.title book.title
  json.year book.year
  json.description book.description
  json.created_at book.created_at
  json.updated_at book.updated_at
  
  if book.author
    json.author do
      json.id book.author.id
      json.name book.author.name
      json.bio book.author.bio
      json.active book.author.active
    end
  else
    json.author nil
  end
end

json.pagination do
  json.current_page @books.current_page
  json.per_page @books.limit_value
  json.total_pages @books.total_pages
  json.total_count @books.total_count
end

