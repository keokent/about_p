# -*- coding: utf-8 -*-
require 'spec_helper'

describe Section do
  
  before { @section = Section.new(name: "人材開発本部") }
  
  subject { @section }
  
  it { should respond_to(:name) }
end
