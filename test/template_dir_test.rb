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

  def test_find_should_be_nil_when_template_name_is_not_found
    name = File.join("poe", "eggplant")
    actual = @target.find(name)
    assert actual.nil?
  end

  def test_list_is_list_up_erb_files_in_root_dir
    expected = (0...10).map { SecureRandom.hex(10) }
    expected.each {|name|  FileUtils.touch(File.join(@dir, "#{name}.erb")) }
    actual = @target.list()
    expected.each do |name|
      assert actual.find(name)
    end
  end

  def test_initializer_should_be_create_template_directory_when_create_dir_equal_true_and_not_exist_the_directory
    @target = TouchErb::TemplateDir.new(File.join(@dir, "test"))
    assert(!Dir.glob(File.join('test'), base:@dir).empty?)
  end

  def test_initializer_should_not_be_create_template_directory_when_create_dir_equal_false_and_not_exist_the_directory
    @target = TouchErb::TemplateDir.new(File.join(@dir, "test"), false)
    assert(Dir.glob(File.join('test'), base:@dir).empty?)
  end

  def teardown
    FileUtils.rmtree(@dir)
  end
end
