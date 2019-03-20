require 'test_helper'
require 'bundler/inline'

class GemLoaderTest < Minitest::Test
  def setup
    @dir = File.join(__dir__, 'tmp/gemloader_test')
    FileUtils.mkdir_p(@dir)
    File.open(File.join(@dir, "Gemfile"), "w") do |f|
      f.puts <<"EOS"
source 'https://rubygems.org'
gem 'to_gunma', '0.0.2'
EOS
    end
    @target = TouchErb::GemLoader.new(@dir)
  end

  def test_load_should_be_import_gems
    @target.load()
    array = [1,2,3].to_gunma!
    assert(array.to_s == "Arrayは群馬県になりました。")
  end

  def teardown
    FileUtils.rmtree(@dir)
  end
end
