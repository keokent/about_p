# -*- coding: utf-8 -*-
class AlterSection < ActiveRecord::Migration
  def change
    section_pairs = [["ホスティング事業本部", "ホスティング事業部"],
                     ["インフラチーム",      "福岡インフラチーム"],
                     ["EC事業本部",         "EC事業部"],
                     ["メディア事業本部",    "メディア事業部"],
                     ["事業開発",           "本社事業部"],
                     ["経営管理本部",       "コーポレート部"],
                     ["総務",              "総務経理"],
                     ["社長室",            "経営企画"],
                     ["人材開発本部",       "人材開発"],
                     ["国際化推進室",       "国際化推進部"]]

    section_pairs.each do |before, after|
      section = Section.find_by(name: before)
      if section
        section.name = after
        puts "#{before} to #{after}"
        puts section.inspect
        section.save!
      end
    end

    %w(福岡アプリ開発チーム 30days\ Album ECインフラチーム).each do |name|
      unless Section.find_by(name: name)
        puts "create #{name}"
        Section.create(name: name)
      end
    end

    section = Section.find_by(name: "経理財務")
    if section
      puts "destroy #{section.name}"
      section.destroy
    end

    puts "complete!!"
  end
end
