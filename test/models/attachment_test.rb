require 'test_helper'

class AttachmentTest < ActiveSupport::TestCase

  setup do
    test "attachment should be valid" do
     assert @attachment.valid?
   end

   test "attachment should be invalid " do
     @attachment.uuid = ''
     refute @attachment.valid?
     assert_not_nil @rattachment.errors[:uuid]
   end

   test "attachment should be invalid without csv_file" do
     attach = Attachment.new
     refute @attach.valid?
     assert_not_nil @attach.errors[:csv_file]
   end
  end
end
