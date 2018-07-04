require 'fastlane/plugin/instabug_rn_sourcemap/version'

module Fastlane
  module InstabugRnSourcemap
    # Return all .rb files inside the "actions" directory
    def self.all_classes
      Dir[File.expand_path('**/{actions}/*.rb', File.dirname(__FILE__))]
    end
  end
end

# By default we want to import all available actions and helpers
# A plugin can contain any number of actions and plugins
Fastlane::InstabugRnSourcemap.all_classes.each do |current|
  require current
end
