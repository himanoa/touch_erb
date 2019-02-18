require 'fileutils'

module TouchErb
  class TemplateDir
    def initialize(root_dir = ENV['TOUCH_ERB_ROOT'] || File.join(Dir.home, '.touch_erb'))
      FileUtils.mkdir_p(root_dir) unless Dir.exist?(root_dir)
      @root =  root_dir
    end

    def find(template_name)
      absolute_path = "#{File.join(@root, template_name)}.erb"
      File.read(absolute_path) if File.exist?(absolute_path)
    end

    def add(template_name)
      absolute_path = File.join(@root, "#{template_name}.erb")
      FileUtils.touch(absolute_path)
      absolute_path
    end

    def list()
      Dir.glob("*.erb", base: @root).map { |filename| File.basename(filename, '.erb') }
    end
  end
end
