# -*- coding: utf-8 -*-
require 'spec_helper'

describe "UserPages" do

  before do
    %w(ホスティング事業本部 ロリポップ！ ムームードメイン インフラチーム
       福岡カスタマーサービス minne 福岡支社付 EC事業本部 カラーミーショップ
       カラメル 運営支援 グーペ ECカスタマーサービス メディア事業本部 JUGEM heteml
       スマホサービス 事業開発 petit 経営管理本部 法務 総務 経理財務
       情報システム部 人材開発本部 国際化推進室 ジュゲムカート 内部監査室
       社長室 技術基盤 ブクログ).each do |name|
      Section.create(name: name)
    end
  end

  subject { page }

  describe "index" do
    let(:user) { FactoryGirl.create(:user, github_uid: "12345") }
    before { sign_in user }

    it "「みんな」とメッセージが表示されるべき" do
      expect(page).to have_content('みんな')
    end
  end

  describe "new" do
    before { sign_in }

    describe "no user" do
      it "ユーザ登録ベージにいるべき" do
        expect(page).to have_button('登録する')
      end
    end

    describe "不正なデータが入力されたとき" do
      before do
        fill_in "名前", with: " "
        select "JUGEM", :from => "部署"
        select "エンジニア", :from => "職種"
        fill_in "IRCの名前", with: "12345"
        click_button '登録する'
      end

      it "エラーが表示されるべき" do
        expect(page).to have_button('登録する')
        expect(page).to have_selector("div.error")
      end
    end

    describe "Twitter_idに不正なデータが入力されたとき" do
      before do
        fill_in "名前", with: "きたけい "
        select "JUGEM", :from => "部署"
        select "エンジニア", :from => "職種"
        fill_in "IRCの名前", with: "12345"
        fill_in "Twitterアカウント", with: "abcdQQ!!!"
        click_button '登録する'
      end

      it "エラーが表示されるべき" do
        expect(page).to have_selector("div.error")
      end
    end

    describe "正しいデータ入力されたとき" do
      before do
        fill_in "名前", with: "喜多啓介"
        select "人材開発本部", :from => "部署"
        select "エンジニア", :from => "職種"
        fill_in "ニックネーム", with: "きたけー"
        fill_in "IRCの名前", with: "kita_k"
        click_button '登録する'
      end

      it "「aboutPへようこそ」とメッセージが表示されるべき" do
        expect(page).to have_content('aboutPへようこそ')
      end

      describe  "プロフィールページで" do
        let(:user) { User.find_by(irc_name: 'kita_k') }
        before { visit user_path(user) }

        it "GitHub名が自動的に表示されているべき" do
          expect(page).to have_content('kitak')
        end
      end
    end
  end

  describe "show" do
    let(:user) { FactoryGirl.create(:user, github_uid:"12345",
                                    face_image: open(File.expand_path("../../fixtures/icon.jpg", __FILE__)),
                                    birthday: Date.new(1988,01,10), birthplace: "東京都",
                                    married: "未婚", background: "ペパボ大学出身",
                                    ppb_join: "2013年", ppb_carrier: "研修中",
                                    hometown: "渋谷", twitter_id: "pepabo",
                                    blog_url: "http://www.paperboy.co.jp/",
                                    hobby: "インターネット", favorite_food: "からあげ",
                                    favorite_book: "ぺぱぼん", club: "バレーボール部",
                                    strong_point: "長所は", free_space: "ここはフリー欄です")
    }

    before do
      sign_in user
      visit user_path(user)
    end

    describe "ユーザの登録情報が表示されているべき" do
      it { should have_content(user.name) }
      it { should have_content(user.nickname) }
      it { should have_content(user.irc_name) }
      it { should have_selector("img[src='#{user.face_image_url(:profile_thumb).to_s}']") }
      it { should have_content(user.section.name) }
      it { should have_content(user.job_type_text) }
      it { should have_content(user.birthday) }
      it { should have_content(user.birthplace) }
      it { should have_content(user.married) }
      it { should have_content(user.background) }
      it { should have_content(user.ppb_join) }
      it { should have_content(user.ppb_carrier) }
      it { should have_content(user.hometown) }
      it { should have_content(user.twitter_id) }
      it { should have_content(user.blog_url) }
      it { should have_content(user.hobby) }
      it { should have_content(user.favorite_food) }
      it { should have_content(user.favorite_book) }
      it { should have_content(user.club) }
      it { should have_content(user.strong_point) }
      it { should have_content(user.free_space) }
    end

    context "/users/:nick でアクセスしたとき" do
      before do
        visit user_path(user.nickname)
      end

      describe "ユーザの登録情報が表示されているべき" do
        it { should have_content(user.name) }
        it { should have_content(user.nickname) }
        it { should have_content(user.irc_name) }
        it { should have_selector("img[src='#{user.face_image_url(:profile_thumb).to_s}']") }
        it { should have_content(user.section.name) }
        it { should have_content(user.job_type_text) }
        it { should have_content(user.birthday) }
        it { should have_content(user.birthplace) }
        it { should have_content(user.married) }
        it { should have_content(user.background) }
        it { should have_content(user.ppb_join) }
        it { should have_content(user.ppb_carrier) }
        it { should have_content(user.hometown) }
        it { should have_content(user.twitter_id) }
        it { should have_content(user.blog_url) }
        it { should have_content(user.hobby) }
        it { should have_content(user.favorite_food) }
        it { should have_content(user.favorite_book) }
        it { should have_content(user.club) }
        it { should have_content(user.strong_point) }
        it { should have_content(user.free_space) }
      end
    end
  end

  describe "edit" do
    let(:new_hometown) { "目黒青葉台" }
    let(:update_button_text) { "更新する" }

    before do
      @section = Section.find_by(name: "人材開発本部")
      @user = @section.users.create(name: "喜多啓介",
                                    job_type: :engineer,
                                    github_uid: "12345",
                                    irc_name: "kitak",
                                    hometown: "渋谷")
      sign_in @user
      visit edit_user_path(@user)
    end

    it { should have_button(update_button_text) }
    it { should have_selector("input#user_name[value='喜多啓介']")}

    context "項目に正しいデータを入力して更新ボタンを押したとき" do
      before do
        fill_in "どこに住んでますか？", with: new_hometown
        click_button update_button_text
      end

      it "データベースの値が更新されるべき" do
        expect(@user.reload.hometown).to eq new_hometown
      end

      it "プロフィールページで更新された値が表示されるべき" do
        expect(page).to have_content(new_hometown)
      end

      it "「プロフィールを更新しました」とメッセージが表示されるべき" do
        expect(page).to have_selector('div.alert.alert-success')
        expect(page).to have_content('プロフィールを更新しました')
      end
    end

    it "項目に不正なデータを入力して更新ボタンを押すとエラーが表示されるはず" do
      fill_in "名前", with: ""
      click_button update_button_text
      expect(page).to have_selector('div.error')
    end
  end

  describe "サービスロゴ" do
    let(:logo_link_selector) { '/html/body/header/div/a' }

    context "サインインしているとき" do
      before do
        @section = Section.find_by(name: "人材開発本部")
        @user = @section.users.create(name: "喜多啓介",
                                      job_type: :engineer,
                                      github_uid: "12345",
                                      irc_name: "kitak",
                                      hometown: "渋谷")
        sign_in @user
      end

      it "トップページにいるときにロゴをクリックしたらトップページへ移動する" do
        visit users_path
        find(logo_link_selector).click
        expect(page).to have_content('みんな')
      end

      it "プロフィールページにいるときにロゴをクリックしたらトップページへ移動する" do
        visit user_path(@user)
        find(logo_link_selector).click
        expect(page).to have_content('みんな')
      end

      it "プロフィール編集ページにいるときにロゴをクリックしたらトップページへ移動する" do
        visit user_path(@user)
        find(logo_link_selector).click
        expect(page).to have_content('みんな')
      end
    end

    context "サインインしていないとき" do
      it "サインインページではヘッダーにロゴは表示されない" do
        visit signin_path
        expect(page).not_to have_selector(logo_link_selector)
      end
    end
  end
end
