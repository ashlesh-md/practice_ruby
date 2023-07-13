class BookRepresenter
  def initialize(books)
    @books = books
  end

  def as_json
    @books.map do |book|
      {
        id: book.id,
        title: book.title,
        author_name: author_name(book.author),
        author_age: book.author.age
      }
    end
  end

  private
  attr_reader :books

  def author_name(author)
    "#{author.first_name} #{author.last_name}"
  end
end
