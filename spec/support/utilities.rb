def sign_in(user=nil)
  visit signin_path
  find(".btn_signin a[href='/auth/github']").click
  cookies[:remember_token] = user.remember_token if user
end
