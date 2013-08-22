namespace :db do
  desc "Fill database with section data"
  task generate_sections: :environment do
    %w(ホスティング事業本部 ロリポップ！ ムームードメイン インフラチーム
       福岡カスタマーサービス minne 福岡支社付 EC事業本部 カラーミーショップ
       カラメル 運営支援 グーペ ECカスタマーサービス メディア事業本部 JUGEM heteml
       スマホサービス 事業開発 petit 経営管理本部 法務 総務 経理財務
       情報システム部 人材開発本部 国際化推進室 ジュゲムカート 内部監査室
       社長室 技術基盤 ブクログ 社長・取締役).each do |name|
      # TODO: iconは用意できたら読み込む
      Section.create(name: name)
    end
  end

  desc "make promotion strategy section"
  task generate_promotion: :environment do
    Section.create(name: "プロモーション戦略部")
  end

  desc "make dummy with users data"
  task generate_dummy_users: :environment do
    14.times do |n|
      name = Forgery::Name.full_name
      irc_name = Forgery::Name.first_name
      section = Section.find_by(name: "ロリポップ！")
      user =  section.users.create(name: name,
                            irc_name: irc_name,
              		    job_type: :engineer,
			    github_uid: "lolipo#{n}")
      puts user.errors.full_messages
    end

    9.times do |n|
      name = Forgery::Name.full_name
      irc_name = Forgery::Name.first_name
      section = Section.find_by(name: "ムームードメイン")
      section.users.create(name: name,
                           irc_name: irc_name,
                           job_type: :designer,
			   github_uid: "muumuu#{n}")
    end

    29.times do |n|
      name = Forgery::Name.full_name
      irc_name = Forgery::Name.last_name
      section = Section.find_by(name: "福岡カスタマーサービス")
      section.users.create(name: name,
                           irc_name: irc_name,
                           job_type: :backoffice,
			   github_uid: "fukuokaCS#{n}")
    end

    20.times do |n|
      name = Forgery::Name.full_name
      irc_name = Forgery::Name.last_name
      section = Section.find_by(name: "カラーミーショップ")
      section.users.create(name: name,
                           irc_name: irc_name,
                           job_type: :manager,
			   github_uid: "colorme#{n}")
    end

    13.times do |n|
      name = Forgery::Name.full_name
      irc_name = Forgery::Name.first_name
      section = Section.find_by(name: "カラメル")
      section.users.create(name: name,
                           irc_name: irc_name,
                           job_type: :producer,
			   github_uid: "calamel#{n}")
    end

    16.times do |n|
      name = Forgery::Name.full_name
      irc_name = Forgery::Name.last_name
      section = Section.find_by(name: "JUGEM")
      section.users.create(name: name,
                           irc_name: irc_name,
                           job_type: :designer,
			   github_uid: "JUGEM#{n}")
    end
  end
end
