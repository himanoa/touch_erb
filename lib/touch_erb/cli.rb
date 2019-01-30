require 'touch_erb'
require 'thor'
require 'erb'

module TouchErb
  class CLI < Thor
    def initialize(*args)
      super

      @template_dir = TouchErb::TemplateDir.new
    end

    desc "add <source>", "Create new erb file"
    def add(source)
      path = @template_dir.add(source)
      system("#{ENV['EDITOR']}", path)
    end
  end
end
