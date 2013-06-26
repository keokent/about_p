require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit signin_path }
    let(:signin_button_text) { 'Sign in with Github' }
    let(:create_user_text) { '登録する' }

    it { should have_content(signin_button_text) }

    context "ユーザを作成していない" do
      it "認証が通ったらユーザ作成画面が表示される" do
        click_link 'Sign in with Github'
        expect(page).to have_button(create_user_text)
      end
    end

    context "ユーザを作成済みである" do
      before do
        @section = Section.create(name: "人材開発本部")
        @user = @section.users.create(name: "Keisuke KITA",
                                      irc_name: "kitak",
                                      github_uid: "12345",
                                      job_type: :engineer)
      end

      it "認証が通ったらユーザ一覧ページへ移動する" do
        click_link signin_button_text 
        expect(page).to have_content('みんな') 
      end
    end

    context "not throught github authentication" do
      before { visit new_user_path }

      it { should have_content(signin_button_text) }
    end
  end
end
