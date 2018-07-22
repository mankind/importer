require 'test_helper'

class AttachmentsControllerTest < ActionDispatch::IntegrationTest
   setup do
    @user = users(:one)
  end

  test "should build upload file and attachment model" do
    sign_in(@user)
    file = fixture_file_upload('files/comic_books.csv', 'text/csv')

    csv_name = file.original_filename
    assert_difference "Attachment.count" do

      post import_attachments_url, params: {file: file} 
      book = @user.books_from_last_csv
      assert_equal 1, book.size
      assert_equal 'comic_books.csv', book.first.csv_name
      assert_redirected_to root_path
    end

  end
end
