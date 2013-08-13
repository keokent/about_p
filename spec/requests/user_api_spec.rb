# -*- coding: utf-8 -*-
require 'spec_helper'

describe "User API" do

  before do
    %w(ホスティング事業本部 ロリポップ！ ムームードメイン インフラチーム
       福岡カスタマーサービス minne 福岡支社付 EC事業本部 カラーミーショップ
       カラメル 運営支援 グーペ ECカスタマーサービス メディア事業本部 JUGEM heteml
       スマホサービス 事業開発 petit 経営管理本部 法務 総務 経理財務
       情報システム部 人材開発本部 国際化推進室 ジュゲムカート 内部監査室
       社長室 技術基盤 ブクログ).each do |name|
      Section.create(name: name)
    end

    @section = Section.find_by(name: "人材開発本部")
    @section.users.create(name: "きたけー",
                          job_type: :engineer,
                          github_uid: "12345",
                          github_name: "kitak",
                          nickname: "kitak",
                          irc_name: "kitak",
                          hometown: "渋谷")
    @section.users.create(name: "武尾様",
                          job_type: :engineer,
                          github_uid: "12346",
                          github_name: "keokent",
                          nickname: "keoken",
                          irc_name: "keoken",
                          hometown: "三軒茶屋")
  end

  subject { page }

  describe "/search.json" do
    context "APIキーをヘッダーに渡したとき" do
      before do
        get '/users/search.json', {'query' => 'kitak'}, {'X-AboutP-API-Key' => '12345'}
      end

      it "ステータスコードは200になる" do
        expect(last_response.status).to eq 200
      end

      it "検索結果は一件になる" do
        result = JSON.parse(last_response.body)
        expect(result.size).to eq 1
      end

      it "要素の項目は、名前、ニックネーム、IRCの名前、Githubの名前である" do
        result = JSON.parse(last_response.body)
        columns = ["name", "nickname", "irc_name", "github_name"]
        expect([result[0].keys, columns].flatten.uniq.size).to eq columns.size
      end

      context "名前が近い人がいるとき" do
        before do
          @section.users.create(name: "きとけー",
                                job_type: :engineer,
                                github_uid: "12347",
                                github_name: "kitokey",
                                nickname: "kitokey",
                                irc_name: "kitokey",
                                hometown: "長野？")
          @section.users.create(name: "みたけー",
                                job_type: :engineer,
                                github_uid: "12348",
                                github_name: "mitakey",
                                nickname: "mitakey",
                                irc_name: "mitakey",
                                hometown: "石川")
          @section.users.create(name: "あんちぽっぷ",
                                job_type: :engineer,
                                github_uid: "12349",
                                github_name: "kentaro",
                                nickname: "antipop",
                                irc_name: "antipop",
                                hometown: "東京")
        end

        it "「kit」で検索すると二件ヒットする" do
          get '/users/search.json', {'query' => 'kit'}, {'X-AboutP-API-Key' => '12345'}
          result = JSON.parse(last_response.body)
          expect(result.size).to eq 2
        end

        it "「kita」で検索すると一件ヒットする" do
          get '/users/search.json', {'query' => 'kita'}, {'X-AboutP-API-Key' => '12345'}
          result = JSON.parse(last_response.body)
          expect(result.size).to eq 1
        end

        it "「あんちぽ」で検索すると一件ヒットする" do
          get '/users/search.json', {'query' => 'あんちぽ'}, {'X-AboutP-API-Key' => '12345'}
          result = JSON.parse(last_response.body)
          expect(result.size).to eq 1
        end

        it "「たけー」で検索するとヒットしない" do
          get '/users/search.json', {'query' => 'たけー'}, {'X-AboutP-API-Key' => '12345'}
          result = JSON.parse(last_response.body)
          expect(result.size).to eq 0
        end

        it "「key」で検索するとヒットしない" do
          get '/users/search.json', {'query' => 'key'}, {'X-AboutP-API-Key' => '12345'}
          result = JSON.parse(last_response.body)
          expect(result.size).to eq 0
        end

        it "「くうちゃん」で検索するとヒットしない" do
          get '/users/search.json', {'query' => 'くうちゃん'}, {'X-AboutP-API-Key' => '12345'}
          result = JSON.parse(last_response.body)
          expect(result.size).to eq 0
        end

        context "クエリーが不正の場合" do
          it "クエリーのパラメータがない場合、ステータスコードは403になる" do
            get '/users/search.json', {}, {'X-AboutP-API-Key' => '12345'}
            expect(last_response.status).to eq 403
          end

          it "クエリーが空の場合、ステータスコードは403になる" do
            get '/users/search.json', {'query' => ''}, {'X-AboutP-API-Key' => '12345'}
            expect(last_response.status).to eq 403
          end

          it "クエリーが二文字の場合、ステータスコードは403になる" do
            get '/users/search.json', {'query' => 'ab'}, {'X-AboutP-API-Key' => '12345'}
            expect(last_response.status).to eq 403
          end
        end
      end
    end

    context "APIキーをヘッダーに渡していないとき" do
      it "ステータスコードは403になる" do
        get '/users/search.json', {}, {}
        expect(last_response.status).to eq 403
      end
    end

    context "間違えたAPIキーをヘッダーに渡したとき" do
      it "ステータスコードは403になる" do
        get '/users/search.json', {'query' => 'kitak'}, {'X-AboutP-API-Key' => 'abcdef'}
        expect(last_response.status).to eq 403
      end
    end
  end
end
