require 'rails_helper'

RSpec.describe 'Api::V1::Books', type: :request do
  describe 'GET /api/v1/books' do
    let!(:author1) { create(:author, name: 'John Doe') }
    let!(:author2) { create(:author, name: 'Jane Smith') }
    let!(:book1) { create(:book, title: 'Ruby on Rails Guide', author: author1, year: 2020) }
    let!(:book2) { create(:book, title: 'JavaScript Mastery', author: author2, year: 2021) }
    let!(:book3) { create(:book, title: 'Python Basics', author: author1, year: 2019) }
    let!(:book4) { create(:book, title: 'Advanced Ruby', author: author1, year: 2022) }

    context 'when requesting all books' do
      it 'returns a successful response' do
        get '/api/v1/books', as: :json
        expect(response).to have_http_status(:success)
      end

      it 'returns all books' do
        get '/api/v1/books', as: :json
        json_response = JSON.parse(response.body)
        expect(json_response['books'].length).to eq(4)
      end

      it 'returns correct JSON structure' do
        get '/api/v1/books', as: :json
        json_response = JSON.parse(response.body)
        
        expect(json_response).to have_key('books')
        expect(json_response).to have_key('pagination')
        
        book = json_response['books'].first
        expect(book).to have_key('id')
        expect(book).to have_key('title')
        expect(book).to have_key('year')
        expect(book).to have_key('description')
        expect(book).to have_key('author')
        expect(book).to have_key('created_at')
        expect(book).to have_key('updated_at')
      end

      it 'includes author information in response' do
        get '/api/v1/books', as: :json
        json_response = JSON.parse(response.body)
        
        book = json_response['books'].find { |b| b['id'] == book1.id }
        expect(book['author']).not_to be_nil
        expect(book['author']['id']).to eq(author1.id)
        expect(book['author']['name']).to eq('John Doe')
      end
    end

    context 'with pagination' do
      it 'returns paginated results' do
        get '/api/v1/books', params: { page: 1, per_page: 2 }, as: :json
        json_response = JSON.parse(response.body)
        
        expect(json_response['books'].length).to eq(2)
        expect(json_response['pagination']['current_page']).to eq(1)
        expect(json_response['pagination']['per_page']).to eq(2)
        expect(json_response['pagination']['total_pages']).to eq(2)
        expect(json_response['pagination']['total_count']).to eq(4)
      end

      it 'returns second page correctly' do
        get '/api/v1/books', params: { page: 2, per_page: 2 }, as: :json
        json_response = JSON.parse(response.body)
        
        expect(json_response['books'].length).to eq(2)
        expect(json_response['pagination']['current_page']).to eq(2)
      end

      it 'defaults to page 1 and per_page 10' do
        get '/api/v1/books', as: :json
        json_response = JSON.parse(response.body)
        
        expect(json_response['pagination']['current_page']).to eq(1)
        expect(json_response['pagination']['per_page']).to eq(10)
      end

      it 'limits per_page to maximum 100' do
        get '/api/v1/books', params: { per_page: 200 }, as: :json
        json_response = JSON.parse(response.body)
        
        expect(json_response['pagination']['per_page']).to eq(100)
      end
    end

    context 'with title search' do
      it 'filters books by title' do
        get '/api/v1/books', params: { title: 'Ruby' }, as: :json
        json_response = JSON.parse(response.body)
        
        expect(json_response['books'].length).to eq(2)
        expect(json_response['books'].all? { |b| b['title'].include?('Ruby') }).to be true
      end

      it 'performs case-insensitive search' do
        get '/api/v1/books', params: { title: 'ruby' }, as: :json
        json_response = JSON.parse(response.body)
        
        expect(json_response['books'].length).to eq(2)
      end

      it 'returns empty array when no matches found' do
        get '/api/v1/books', params: { title: 'NonExistentBook' }, as: :json
        json_response = JSON.parse(response.body)
        
        expect(json_response['books']).to be_empty
      end
    end

    context 'with author_id filter' do
      it 'filters books by author_id' do
        get '/api/v1/books', params: { author_id: author1.id }, as: :json
        json_response = JSON.parse(response.body)
        
        expect(json_response['books'].length).to eq(3)
        expect(json_response['books'].all? { |b| b['author']['id'] == author1.id }).to be true
      end

      it 'returns empty array when author has no books' do
        author3 = create(:author)
        get '/api/v1/books', params: { author_id: author3.id }, as: :json
        json_response = JSON.parse(response.body)
        
        expect(json_response['books']).to be_empty
      end
    end

    context 'with combined filters' do
      it 'filters by both title and author_id' do
        get '/api/v1/books', params: { title: 'Ruby', author_id: author1.id }, as: :json
        json_response = JSON.parse(response.body)
        
        expect(json_response['books'].length).to eq(2)
        expect(json_response['books'].all? { |b| b['title'].include?('Ruby') && b['author']['id'] == author1.id }).to be true
      end
    end

    context 'with book without author' do
      let!(:book_without_author) { create(:book_without_author, title: 'Orphan Book') }

      it 'returns null for author when book has no author' do
        get '/api/v1/books', as: :json
        json_response = JSON.parse(response.body)
        
        book = json_response['books'].find { |b| b['id'] == book_without_author.id }
        expect(book['author']).to be_nil
      end
    end
  end

  describe 'GET /api/v1/books/:id' do
    let!(:author) { create(:author, name: 'Test Author') }
    let!(:book) { create(:book, title: 'Test Book', author: author, year: 2020, description: 'Test description') }

    context 'when book exists' do
      it 'returns a successful response' do
        get "/api/v1/books/#{book.id}", as: :json
        expect(response).to have_http_status(:success)
      end

      it 'returns the correct book' do
        get "/api/v1/books/#{book.id}", as: :json
        json_response = JSON.parse(response.body)
        
        expect(json_response['id']).to eq(book.id)
        expect(json_response['title']).to eq('Test Book')
        expect(json_response['year']).to eq(2020)
        expect(json_response['description']).to eq('Test description')
      end

      it 'returns correct JSON structure' do
        get "/api/v1/books/#{book.id}", as: :json
        json_response = JSON.parse(response.body)
        
        expect(json_response).to have_key('id')
        expect(json_response).to have_key('title')
        expect(json_response).to have_key('year')
        expect(json_response).to have_key('description')
        expect(json_response).to have_key('author')
        expect(json_response).to have_key('created_at')
        expect(json_response).to have_key('updated_at')
      end

      it 'includes author information' do
        get "/api/v1/books/#{book.id}", as: :json
        json_response = JSON.parse(response.body)
        
        expect(json_response['author']).not_to be_nil
        expect(json_response['author']['id']).to eq(author.id)
        expect(json_response['author']['name']).to eq('Test Author')
      end
    end

    context 'when book does not exist' do
      it 'returns 404 status' do
        get '/api/v1/books/99999', as: :json
        expect(response).to have_http_status(:not_found)
      end

      it 'returns error message' do
        get '/api/v1/books/99999', as: :json
        json_response = JSON.parse(response.body)
        
        expect(json_response).to have_key('error')
        expect(json_response['error']).to eq('Book not found')
      end
    end

    context 'with book without author' do
      let!(:book_without_author) { create(:book_without_author) }

      it 'returns null for author' do
        get "/api/v1/books/#{book_without_author.id}", as: :json
        json_response = JSON.parse(response.body)
        
        expect(json_response['author']).to be_nil
      end
    end
  end
end

