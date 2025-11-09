# GraphQL Examples

## Endpoints

- **GraphQL API**: `POST /graphql`
- **GraphiQL IDE**: `GET /graphiql` (тільки в development)

## Query: Отримання списку книг

```graphql
query {
  books {
    id
    title
    author
    year
    description
    createdAt
    updatedAt
    authorRecord {
      id
      name
      bio
    }
  }
}
```

## Mutation: Створення книги

```graphql
mutation {
  createBook(title: "1984", author: "George Orwell", year: 1949) {
    book {
      id
      title
      author
      year
    }
    errors
  }
}
```

## Приклад повного циклу (створення та отримання)

```graphql
# 1. Створити книгу
mutation {
  createBook(title: "The Great Gatsby", author: "F. Scott Fitzgerald", year: 1925) {
    book {
      id
      title
      author
      year
    }
    errors
  }
}

# 2. Отримати всі книги
query {
  books {
    id
    title
    author
    year
  }
}
```
