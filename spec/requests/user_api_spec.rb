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
  end

  subject { page }

  describe "/search.json" do
    context "APIキーをヘッダーに渡したとき" do
      it "ステータスコードは200になる" do
        get '/users/search.json', {}, {'X-AboutP-API-Key' => '12345'}
        expect(last_response.status).to eq 200
      end
    end

    context "APIキーをヘッダーに渡していないとき" do
      it "ステータスコードは403になる" do
        get '/users/search.json', {}, {}
        expect(last_response.status).to eq 403
      end
    end
  end
end
