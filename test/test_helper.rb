$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "touch_erb"

require "minitest/autorun"
require "minitest/reporters"

Minitest::Reporters.use!
