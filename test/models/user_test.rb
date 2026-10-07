require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "no debe guardar usuario sin email" do
    user = User.new(password: "123456", role: :member)
    assert_not user.save, "Guardó el usuario sin email"
  end
end
