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
        expect(page).to have_content('error')
      end
    end	   
  end

  describe "edit" do
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

    it { should have_button('更新する') }
    it { should have_selector("input#user_name[value='喜多啓介']")}
  end
end
