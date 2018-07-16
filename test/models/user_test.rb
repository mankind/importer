require 'test_helper'

class UserTest < ActiveSupport::TestCase
   setup do
    @first_user = users(:one)
   end


   test "user should be valid with name, email and password" do
     assert @first_user.valid?
   end

   test "user should be invalid without email" do
     @first_user.email = ''
     refute @first_user.valid?
     assert_not_nil @first_user.errors[:email]
   end

   test "user should be invalid without name" do
     @first_user.name = ''
     refute @first_user.valid?
     assert_not_nil @first_user.errors[:name]
   end



end
