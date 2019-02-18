$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "touch_erb"

require "minitest/autorun"
require "minitest/reporters"
require "minitest/power_assert"
require "minitest/autorun"

Minitest::Reporters.use!
