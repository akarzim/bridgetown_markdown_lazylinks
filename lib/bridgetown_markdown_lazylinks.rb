# frozen_string_literal: true

require "bridgetown"
require "bridgetown_markdown_lazylinks/converter"

# Mandatory plugin initializer
#
# @see https://github.com/bridgetownrb/bridgetown/issues/769#issuecomment-1596520674
#
# @param config [Bridgetown::Configuration::ConfigurationDSL]
Bridgetown.initializer :bridgetown_markdown_lazylinks do |_|
  # noop
end
