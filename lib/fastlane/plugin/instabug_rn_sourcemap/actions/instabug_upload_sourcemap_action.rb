require 'fastlane/action'

module Fastlane
  module Actions
    class InstabugUploadSourcemapAction < Action
      ENDPOINT = "https://api.instabug.com/api/sdk/v3/symbols_files"

      def self.run(params)
        api_token = params[:api_token]
        sourcemap_file = params[:sourcemap_file]

        command = 
          "curl #{ENDPOINT} " \
          "--write-out %{http_code} " \
          "--silent " \
          "--output /dev/null " \
          "-F platform='react_native' " \
          "-F os='#{lane_context[:PLATFORM_NAME]}' " \
          "-F symbols_file=@#{sourcemap_file} "\
          "-F application_token='#{api_token}'"

        result = Actions.sh(command)
        if (result == "200")
          UI.success "Successfully uploaded sourcemap file to Instabug"
        else
          UI.error "Error uploading sourcemap to Instabug. Bad API Token?"
        end
      end

      def self.description
        "Uploads ios/android sourcemaps to Instabug"
      end

      def self.authors
        ["Bryan Ricker"]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        # Optional:
        "Uploads ios/android sourcemaps to Instabug"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new({
            key: :api_token,
            env_name: "FL_INSTABUG_API_TOKEN",
            description: "Your Instabug API Token",
            optional: false,
            type: String
          }),
          FastlaneCore::ConfigItem.new({
            key: :sourcemap_file,
            env_name: "FL_SOURCEMAP_FILE",
            description: "Path to the sourcemap file to upload",
            optional: false,
            type: String,
            verify_block: ->(value) {
              UI.user_error!("File #{value} doesn't exist. Add --sourcemap-output option to react-native build") unless File.exist?(value)
              UI.user_error!("Sourcemap file must be json") unless File.extname(value) == '.json'
            }
          }),
        ]
      end

      def self.is_supported?(platform)
        # Adjust this if your plugin only works for a particular platform (iOS vs. Android, for example)
        # See: https://docs.fastlane.tools/advanced/#control-configuration-by-lane-and-by-platform
        #
        # [:ios, :mac, :android].include?(platform)
        true
      end
    end
  end
end
