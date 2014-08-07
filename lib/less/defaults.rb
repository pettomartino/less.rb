module Less
  module Defaults

    def defaults
      @defaults ||= { :paths => [], :syncImport => true }
    end

    def paths
      defaults[:paths]
    end

  end
end
