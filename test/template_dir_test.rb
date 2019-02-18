require "test_helper"
require "securerandom"

class TempalteDirTest < Minitest::Test
  def setup
    @dir = File.join(__dir__, 'tmp')
    FileUtils.mkdir_p(@dir)
    @target = TouchErb::TemplateDir.new(@dir)
  end

  def test_add_is_create_erb_file
    name = "ttene"
    actual = @target.add(name)
    assert File.exist?(File.join(@dir, "#{name}.erb"))
    assert actual == File.join(@dir, "#{name}.erb")
  end

  def test_find_is_find_erb_file_in_root_dir
    name = "eggplant"
    FileUtils.touch(File.join(@dir, "#{name}.erb"))
    actual = @target.find(name)
    assert actual
  end

  def test_list_is_list_up_erb_files_in_root_dir
    expected = (0...10).map { SecureRandom.hex(10) }
    expected.each {|name|  FileUtils.touch(File.join(@dir, "#{name}.erb")) }
    actual = @target.list()
    expected.each do |name|
      assert actual.find(name)
    end
  end

  def teardown
    FileUtils.rmtree(@dir)
  end
end
