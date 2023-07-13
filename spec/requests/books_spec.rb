require 'rails_helper'

describe "Books API", type: :request do
  describe "GET /books" do
    it 'returns all books' do
      FactoryBot.create(:book, title: 'Book', author: FactoryBot.create(:author, first_name: "Alex", last_name: "Hales", age: 61))
      FactoryBot.create(:book, title: 'Book2', author: FactoryBot.create(:author, first_name: "Alex", last_name: "Hales", age: 61))
      get '/api/v1/books'
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  describe "POST /books" do
    it 'creates a new book' do
      expect {
        post '/api/v1/books', params: { book: { title: "The Martin", author: { first_name: "Alex", last_name: "Hales", age: 61 } } }
      }.to change { Book.count }.from(0).to(1)
      expect(response).to have_http_status(:created)
      expect(Author.count).to eq(1)
    end
  end

  describe "DELETE /books/:id" do
    let!(:book) { FactoryBot.create(:book, title: 'Book', author: FactoryBot.create(:author, first_name: "Alex", last_name: "Hales", age: 61)) }
    it 'deletes a book' do
      expect {
        delete "/api/v1/books/#{book.id}"
      }.to change { Book.count }.from(1).to(0)
      expect(response).to have_http_status(:no_content)
    end
  end
end
