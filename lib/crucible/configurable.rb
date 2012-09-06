module Crucible
  module Configurable
    attr_accessor :endpoint

    def self.keys
      [
       :endpoint
      ]
    end

    def self.configure
      yield self
      self
    end

    def load_config!
      file = if File.exists?("~/.cruciblerc")
               "~/cruciblerc"
             elsif File.exists?("./.cruciblerc")
               "./.cruciblerc"
             end

      if file
        config = YAML.load(file)

        config.keys.each do |key|
          instance_variable_set("@#{key}", config[key])
        end
      end
    end
  end
end
