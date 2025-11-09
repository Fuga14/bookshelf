require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'associations' do
    it { should belong_to(:author).optional }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:year) }
    it { should validate_numericality_of(:year).only_integer }
    
    it 'validates year is between 1900 and 2030' do
      book = build(:book, year: 1899)
      expect(book).not_to be_valid
      expect(book.errors[:year]).to be_present
    end

    it 'allows year 1900' do
      book = build(:book, year: 1900)
      expect(book).to be_valid
    end

    it 'allows year 2030' do
      book = build(:book, year: 2030)
      expect(book).to be_valid
    end

    it 'rejects year 2031' do
      book = build(:book, year: 2031)
      expect(book).not_to be_valid
      expect(book.errors[:year]).to be_present
    end

    it 'rejects non-integer year' do
      book = build(:book, year: 2020.5)
      expect(book).not_to be_valid
      expect(book.errors[:year]).to be_present
    end
  end

  describe 'valid book creation' do
    it 'creates a valid book with all attributes' do
      author = create(:author)
      book = build(:book, author: author, title: 'Test Book', year: 2020, description: 'Test description')
      
      expect(book).to be_valid
      expect(book.save).to be true
    end

    it 'creates a valid book without author' do
      book = build(:book_without_author, title: 'Test Book', year: 2020)
      
      expect(book).to be_valid
      expect(book.save).to be true
    end
  end

  describe 'invalid book creation' do
    it 'fails without title' do
      book = build(:book, title: nil)
      expect(book).not_to be_valid
      expect(book.errors[:title]).to be_present
    end

    it 'fails without year' do
      book = build(:book, year: nil)
      expect(book).not_to be_valid
      expect(book.errors[:year]).to be_present
    end
  end
end

