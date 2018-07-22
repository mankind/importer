require 'test_helper'

class BookTest < ActiveSupport::TestCase

  setup do
    @book = books(:one)
  end

  test "book should be valid" do
     assert @book.valid?
   end

  test "book should be invalid without uuid" do
     @book.uuid = ''
     refute @book.valid?
     assert_not_nil @book.errors[:uuid]
  end

  test "book is created from uploaded CSV file "  do
     user = users(:one)
     Current.user = user
     file_path = Rails.root.join('test/fixtures/files/comic_books.csv')
     file = Rack::Test::UploadedFile.new(file_path)
     csv_name = file.original_filename
     Book.create_books_from_csv(file)
     book = Book.find_by(csv_name: csv_name)

    assert_equal 'comic book', book.title 
  end

end
