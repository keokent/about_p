require 'spec_helper'

describe User do
  before do
    @user = User.new(name: "Kenta Takeo",
                            section_id: 1,
                            job_type: 1,
                            github_id: "1",
                            irc_name: "keoken")
  end

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:section_id) }
  it { should respond_to(:job_type) }
  it { should respond_to(:github_id) }
  it { should respond_to(:irc_name) }

  describe "when name is not present" do
    before { @user.name = "" }
    it { should_not be_valid }
  end
end

  
