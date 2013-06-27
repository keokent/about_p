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

    it "「aboutPへようこそ」とメッセージが表示されるべき" do
      expect(page).to have_content('aboutPへようこそ')
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
        fill_in "お名前", with: " "
        select "JUGEM", :from => "部署"
        select "エンジニア", :from => "職種"
        fill_in "IRCの名前", with: "12345"
        click_button '登録する'
      end

      it "エラーが表示されるべき" do
        expect(page).to have_button('登録する')
        expect(page).to have_content('error')
      end
    end	   

    describe "正しいデータ入力されたとき" do
      before do
        fill_in "お名前", with: "喜多啓介"
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
                                    face_image: open(File.expand_path("../../fixtures/icon.jpg", __FILE__))) }
    
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
      it { should have_content(user.job_type) }
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
        fill_in "今のお住まいはどこですか", with: new_hometown
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
      fill_in "お名前", with: ""
      click_button update_button_text
      expect(page).to have_content('error')
    end
  end

  describe "サービスロゴ" do
    let(:logo_link_selector) { '/html/body/header/a' }

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
