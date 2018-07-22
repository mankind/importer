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
      #post import_attachments_url, params: {attachment: {csv_file: file, original_csv_filename: csv_name} }

      post import_attachments_url, params: {file: file} 
      assert_equal 1, @user.books_from_last_csv.size
      assert_redirected_to root_path
    end

  end
end
