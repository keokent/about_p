namespace :tmp do
  desc "Fetch paparboy's members"
  task fetch_members: :environment do
    require 'open-uri'
    members_ssv = open("https://raw.github.com/paperboy-all/all/master/github/members.txt?login=kitak&token=#{ENV['FETCH_TOKEN']}").read
    members = {} 
    members_ssv.split("\n").each do |line|
      tmp = line.split(' ')
      next if tmp.size == 1
      members[tmp[0]] = tmp[1..-1].join("")
    end
    open("#{Rails.root}/tmp/ppb_members.json", "w").write members.to_json
  end
end
