require "test_helper"

class Admin::SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    assert_routing({ method: "GET", path: "/admin/login" }, { controller: "admin/sessions", action: "new" })
  end

  test "admin can log in with valid credentials" do
    User.create!(email: "admin-test@example.com", password: "password123", role: :admin)

    post admin_login_path, params: { email: "admin-test@example.com", password: "password123" }

    assert_redirected_to admin_root_path
    assert_equal "Sesión iniciada correctamente.", flash[:notice]
  end

  test "should get destroy" do
    admin = User.create!(email: "admin-test@example.com", password: "password123", role: :admin)
    post admin_login_path, params: { email: admin.email, password: "password123" }

    delete admin_logout_path

    assert_redirected_to admin_login_path
    assert_nil session[:admin_id]
  end
end
