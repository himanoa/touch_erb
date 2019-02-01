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
    option :source, :type => :string
    def add(source)
      path = @template_dir.add(source)
      system("#{ENV['EDITOR']}", path)
    end

    desc "<template_name> <output_name>", "Create file to current directory from execute erb template"
    def touch(i, o)
      puts "hello hello"
    end

    default_task :touch
  end
end

