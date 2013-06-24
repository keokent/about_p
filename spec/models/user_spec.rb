require 'spec_helper'

describe User do
  before { @user = User.new(name: "Kenta Takeo",
                            section_id: 1,
                            job_type: 1,
                            github_id: "1",
                            irc_name: "keoken") }
  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:section_id) }
  it { should respond_to(:job_type) }
  it { should respond_to(:github_id) }
  it { should respond_to(:irc_name) }
end

  
