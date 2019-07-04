require "test_helper"
require "touch_erb/cli"

class TouchErbTest < Minitest::Test
  def setup
    @dir = File.join(__dir__, 'tmp' , 'large')
    FileUtils.mkdir_p(File.join(@dir, '.touch_erb'))
  end

  def test_that_it_has_a_version_number
    refute_nil ::TouchErb::VERSION
  end

  def test_erb_template_can_access_filename
    FileUtils.cd(@dir) do
      erb =
<<EOS
<%= file_name %>
EOS
      File.write(File.join('.touch_erb', 'test_template.erb'), erb)
      TouchErb::CLI.start(%w[touch test_template test_template.js])
      actual = File.read('test_template.js')
      assert{actual == 'test_template'}
    end
  end

  def test_erb_template_can_use_active_support
    FileUtils.cd(@dir) do
      erb =
<<EOS
<%= "apple".pluralize %>
EOS
      File.write(File.join('.touch_erb', 'test_template_pluralize.erb'), erb)
      TouchErb::CLI.start(%w[touch test_template_pluralize])
      actual = File.read('test_template_pluralize')
      assert{actual == 'apples'}
    end
  end

  def test_erb_template_not_create_version_file_when_double_arguments
    FileUtils.cd(@dir) do
      erb =
<<EOS
<%= "apple".pluralize %>
EOS
      File.write(File.join('.touch_erb', 'test_template_pluralize.erb'), erb)
      TouchErb::CLI.start(%w[touch foobar foo])
      actual = File.exist?('--version')
      assert{actual == false}
    end
  end

  def test_touch_arguments_start_with_double_hyphens
    $stdout = StringIO.new
    TouchErb::CLI.start(%w[touch --version])
    actual = $stdout.string
    $stdout = StringIO.new
    TouchErb::CLI.start(%w[touch help])
    expect = $stdout.string
    assert { actual == expect }
    $stdout = STDOUT
  end
  def teardown
    FileUtils.rmtree(@dir)
  end
end
