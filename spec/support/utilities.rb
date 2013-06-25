def sign_in(user=nil)
  visit signin_path
  click_link "Sign in with Github"
  cookies[:remember_token] = user.remember_token if user
end
