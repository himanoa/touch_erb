# frozen_string_literal: true

require 'touch_erb'
require 'thor'
require 'erb'
require 'fileutils'
require 'active_support'
require 'active_support/core_ext'

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

    desc 'add <source>', 'Create new erb file'
    option 'local', aliases: 'l', type: :boolean
    method_option :source, type: :string, desc: 'Create new erb template to {current directory}/.touch_erb/'
    def add(source)
      target_dir = @template_dir
      target_dir = @local_template_dir if options[:local]
      path = target_dir.add(source)
      system((ENV['EDITOR']).to_s, path)
    end

    desc '<template_name> <output_name>', 'Create file to current directory from execute erb template'
    option :template_name, type: :string
    option :output_name, type: :string, default: nil
    def touch(template_name, output_name = nil)
      if template_name.start_with?("--")
        invoke :help
        return
      end
      write_file_name = output_name || template_name
      file_name = File.basename(write_file_name, '.*')
      if FileTest.exist?(file_name)
        FileUtils.touch(file_name)
      else
        File.open(write_file_name, 'w') do |f|
          f.write(ERB.new(@local_template_dir.find(template_name) || @template_dir.find(template_name) || '', trim_mode: '%<>').result(binding))
        end
      end
    end

    desc 'list', 'Show erb templates'
    option 'local', aliases: 'l', type: :boolean, desc: 'Show templates only local directory .touch_erb'
    def list
      if options[:local]
        @local_template_dir.list.each { |name| puts name }
      else
g       (@template_dir.list + @local_template_dir.list).each { |name| puts name }
      end
    end

    default_task :touch

    def self.exit_on_failure?
      true
    end

    desc "version", "Print the version"
    def __version
      puts  "0.4.3"
    end

    desc "--version", "Print the version"
    def version
      __version
    end
  end
end
