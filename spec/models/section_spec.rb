# -*- coding: utf-8 -*-
require 'spec_helper'

describe Section do
  
  before { @section = Section.new(name: "人材開発本部") }
  
  subject { @section }
  
  it { should respond_to(:name) }
  it { should respond_to(:users) }
  
  describe "when name is not present" do
    before { @section.name = "" }
    it { should_not be_valid }
  end
  
  describe "hasmany " do    
    
    before { @section.save }
    let!(:user1) do
      @section.users.create(name: "Kenta Takeo",
                            job_type: 1,
                            github_uid: "keokent",
                            irc_name:"keoken" )
    end
    let!(:user2) do
      @section.users.create(name: "Keisuke Kita",
                            job_type: 1,
                            github_uid: "kitak",
                            irc_name:"kitak" )
    end
    
    it "should have any users" do
      expect(@section.users.to_a).to eq [user1, user2]
      end
  end
end
