# -*- coding: utf-8 -*-
require 'spec_helper'

describe Section do
  
  before { @section = Section.new(name: "人材開発本部") }
  
  subject { @section }
  
  it { should respond_to(:name) }
  
  describe "when name is not present" do
    before { @section.name = "" }
    it { should_not be_valid }
  end
end
