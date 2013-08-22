namespace :db do
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
