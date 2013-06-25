require 'spec_helper'

describe User do
  before do
    @user = User.new(name: "Kenta Takeo",
                            section_id: 1,
                            job_type: :engineer,
                            github_uid: "1",
                            irc_name: "keoken")
  end

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:section_id) }
  it { should respond_to(:job_type) }
  it { should respond_to(:github_uid) }
  it { should respond_to(:irc_name) }

  describe "when name is not present" do
    before { @user.name = "" }
    it { should_not be_valid }
  end

  describe "when section_id is not present" do
    before { @user.section_id = nil }
    it { should_not be_valid }
  end

  describe "when job_type is not present" do
    before { @user.job_type = nil }
    it { should_not be_valid }
  end

  describe "when github_uid is not present" do
    before { @user.github_uid = nil }
    it { should_not be_valid }
  end

  describe "when irc_name is not present" do
    before { @user.irc_name = "" }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @user.name = "a" * 41 }
    it { should_not be_valid }
  end

  describe "when irc_name is too long" do
    before { @user.irc_name = "a" * 41 }
    it { should_not be_valid }
  end
end

  
