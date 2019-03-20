require 'bundler/inline'

module TouchErb
  class GemLoader

    GEMFILE_NAME = 'Gemfile'

    def initialize(root_dir)
      @root_dir = root_dir
    end

    def load
      gemfile_code =  File.read(File.join(@root_dir, GEMFILE_NAME))
      gemfile do
        eval gemfile_code
      end
    end
  end
end
