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
    option :template_name, :type => :string
    option :output_name, :type => :string
    def touch(template_name, output_name)
      File.open(output_name, 'w') do |f|
        f.write(ERB.new(@template_dir.find(template_name), nil, "%<>").result())
      end
    end

    default_task :touch
  end
end

