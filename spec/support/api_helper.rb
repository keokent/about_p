# -*- coding: utf-8 -*-
require 'rack/test'


module ApiHelper
  include Rack::Test::Methods

  def app
    Rails.application
  end
end
