require 'touch_erb'
require 'thor'
require 'erb'
require 'fileutils'

module TouchErb
  class CLI < Thor

    def initialize(*args)
      super
      @template_dir = TouchErb::TemplateDir.new

      @local_template_dir = TouchErb::TemplateDir.new(
        File.join(Dir.pwd, '.touch_erb'),
        false
      )
    end

    desc "add <source>", "Create new erb file"
    option "local", aliases: "l", type: :boolean
    method_option :source, :type => :string, :desc => "Create new erb template to {current directory}/.touch_erb/"
    def add(source)
      target_dir = @template_dir
      if options[:local]
        target_dir = @local_template_dir
      end
      path = target_dir.add(source)
      system("#{ENV['EDITOR']}", path)
    end

    desc "<template_name> <output_name>", "Create file to current directory from execute erb template"
    option :template_name, :type => :string
    option :output_name, :type => :string, :default => nil
    def touch(template_name, output_name = nil)
      dist_name = output_name || template_name
      if FileTest.exists?(dist_name)
        FileUtils.touch(dist_name)
      else
        File.open(dist_name, 'w') do |f|
          f.write(ERB.new(@local_template_dir.find(template_name) || @template_dir.find(template_name) || "", nil, "%<>").result())
        end
      end
    end

    desc "list", "Show erb templates"
    option "local", aliases: "l", type: :boolean, desc: "Show templates only local directory .touch_erb"
    def list()
      if(options[:local])
        @local_template_dir.list().each{ |name| puts name }
      else
        (@template_dir.list() + @local_template_dir.list()).each{ |name| puts name }
      end
    end

    default_task :touch
  end
end

