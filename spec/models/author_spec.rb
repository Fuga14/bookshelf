require 'rails_helper'

RSpec.describe Author, type: :model do
  describe 'associations' do
    it { should have_many(:books).dependent(:restrict_with_error) }
  end

  describe 'scopes' do
    describe '.active' do
      let!(:active_author1) { create(:author, name: 'Author A', active: true) }
      let!(:active_author2) { create(:author, name: 'Author B', active: true) }
      let!(:inactive_author) { create(:author, name: 'Author C', active: false) }

      it 'returns only active authors' do
        expect(Author.active).to include(active_author1, active_author2)
        expect(Author.active).not_to include(inactive_author)
      end

      it 'orders by name' do
        authors = Author.active
        expect(authors.first.name).to eq('Author A')
        expect(authors.second.name).to eq('Author B')
      end
    end
  end

  describe 'dependent: :restrict_with_error' do
    let!(:author) { create(:author) }
    let!(:book1) { create(:book, author: author) }
    let!(:book2) { create(:book, author: author) }

    it 'prevents deletion when author has books' do
      expect { author.destroy }.to raise_error(ActiveRecord::DeleteRestrictionError)
    end

    it 'allows deletion when author has no books' do
      author_without_books = create(:author)
      expect { author_without_books.destroy }.not_to raise_error
      expect(Author.exists?(author_without_books.id)).to be false
    end
  end

  describe 'valid author creation' do
    it 'creates a valid author with all attributes' do
      author = build(:author, name: 'Test Author', bio: 'Test bio', active: true)
      
      expect(author).to be_valid
      expect(author.save).to be true
    end

    it 'creates a valid author with minimal attributes' do
      author = build(:author, name: 'Test Author')
      
      expect(author).to be_valid
      expect(author.save).to be true
    end
  end

  describe 'author with books' do
    let!(:author) { create(:author) }
    let!(:book1) { create(:book, author: author) }
    let!(:book2) { create(:book, author: author) }

    it 'has many books' do
      expect(author.books.count).to eq(2)
      expect(author.books).to include(book1, book2)
    end

    it 'can access books through association' do
      expect(author.books.first).to be_a(Book)
    end
  end
end

