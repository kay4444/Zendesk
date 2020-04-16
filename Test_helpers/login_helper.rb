EMAIL_FIELD_ID = "user_email"
PASSWORD_FIELD_ID = "user_password"

module LoginHelper

  def login(login, password)
    puts "Log in with account: #{login}/#{password}"
    within_frame 0 do
      fill_in(EMAIL_FIELD_ID, with: login)
      fill_in(PASSWORD_FIELD_ID, with: password)
      click_button('Sign in')
    end
  end

end