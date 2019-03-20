require 'touch_erb'
require 'thor'
require 'erb'
require 'fileutils'

module TouchErb
  class CLI < Thor

    def initialize(*args)
      super
      @global_template_dir = ENV['TOUCH_ERB_ROOT'] || File.join(Dir.home, '.touch_erb')
      @global_template_repository = TouchErb::TemplateDir.new(
        @global_template_dir, true
      )

      @local_template_dir = File.join(Dir.pwd, '.touch_erb')
      @local_template_repository = TouchErb::TemplateDir.new(
        @local_template_dir, false
      )
    end

    desc "add <source>", "Create new erb file"
    option "local", aliases: "l", type: :boolean
    method_option :source, :type => :string, :desc => "Create new erb template to {current directory}/.touch_erb/"
    def add(source)
      target_dir = @global_template_repository
      if options[:local]
        target_dir = @local_template_repository
      end
      path = target_dir.add(source)
      system("#{ENV['EDITOR']}", path)
    end

    desc "<template_name> <output_name>", "Create file to current directory from execute erb template"
    option :template_name, :type => :string
    option :output_name, :type => :string, :default => nil
    # TODO: Refactoring
    def touch(template_name, output_name = nil)
      dist_name = output_name || template_name
      if FileTest.exists?(dist_name)
        FileUtils.touch(dist_name)
      else
        File.open(dist_name, 'w') do |f|
          local_template = @local_template_repository.find(template_name)
          global_template = @global_template_repository.find(template_name)
          if(local_template)
            TouchErb::GemLoader.new(@local_template_dir).load
          elsif(global_template)
            TouchErb::GemLoader.new(@global_template_dir).load
          end
          p global_template
          f.write(ERB.new(local_template || global_template || "", nil, "%<>").result())
        end
      end
    end

    desc "list", "Show erb templates"
    option "local", aliases: "l", type: :boolean, desc: "Show templates only local directory .touch_erb"
    def list()
      if(options[:local])
        @local_template_repository.list().each{ |name| puts name }
      else
        (@global_template_repository.list() + @local_template_repository.list()).each{ |name| puts name }
      end
    end

    default_task :touch
  end
end
