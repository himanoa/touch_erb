require 'bundler'

module TouchErb
  class GemLoader

    GEMFILE_NAME = 'Gemfile'

    def initialize(root_dir)
      @root_dir = root_dir
    end

    def load
      builder = Bundler::Dsl.new
      builder.eval_gemfile(File.join(@root_dir, GEMFILE_NAME))
      Bundler::Runtime.new(nil, builder.to_definition(nil, true)).setup.require
    end
  end
end
