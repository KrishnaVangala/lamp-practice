# frozen_string_literal: true
require 'chefspec'
require 'chefspec/berkshelf'

RSpec.configure do |config|
 config.platform = 'centos'
 config.version  = '7.3'
end
