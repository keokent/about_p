require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_content('Sign in with Github') }
  end

  context "not throught github authentication" do
    before { visit new_user_path }

    it { should have_content('Sign in with Github') }
  end
end
