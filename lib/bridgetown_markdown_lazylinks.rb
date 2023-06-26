# frozen_string_literal: true

require "bridgetown"
require "bridgetown_markdown_lazylinks/converter"

# Mandatory plugin initializer
#
# @see https://github.com/bridgetownrb/bridgetown/issues/769#issuecomment-1596520674
#
# @param config [Bridgetown::Configuration::ConfigurationDSL]
# @param [Hash<String, String>] opts custom configuration
# @option opts [String] :placeholder ('*') the basic placeholder
# @option opts [String] :external_placeholder ('+') the external placeholder
#
# rubocop:disable Metrics/LineLength
Bridgetown.initializer :bridgetown_markdown_lazylinks do |config, placeholder: "*", external_placeholder: "+"|
  config.bridgetown_markdown_lazylinks ||= {}
  config.bridgetown_markdown_lazylinks.basic_placeholder = placeholder
  config.bridgetown_markdown_lazylinks.external_placeholder = external_placeholder
end
# rubocop:enable Metrics/LineLength
