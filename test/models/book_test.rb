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

end
