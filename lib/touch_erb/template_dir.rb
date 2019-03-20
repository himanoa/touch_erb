require 'fileutils'

module TouchErb
  class TemplateDir
    attr_accessor :root
    def initialize(root_path, is_create_dir = true)
      @root = root_path
      FileUtils.mkdir_p(root_path) if is_create_dir && !Dir.exist?(root_path)
    end

    def find(template_name)
      absolute_path = "#{File.join(@root, template_name)}.erb"
      if File.exist?(absolute_path)
        File.read(absolute_path)
      else
        nil
      end
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
