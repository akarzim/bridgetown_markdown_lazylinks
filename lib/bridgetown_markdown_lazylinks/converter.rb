# frozen_string_literal: true

module BridgetownMarkdownLazylinks
  # Allows use of `*` link references where the next [*]: href defines the link
  # Inspired by [tidbits][*]
  # [*]: http://tidbits.com
  #
  # Example:
  # mkd = <<-MKD
  # This is my text and [this is my link][*]. I'll define
  # the url for that link under the paragraph.
  #
  # [*]: http://brettterpstra.com
  #
  # I can use [multiple][*] lazy links in [a paragraph][*],
  # and then just define them in order below it.
  #
  # [*]: https://gist.github.com/ttscoff/7059952
  # [*]: http://blog.bignerdranch.com/4044-rock-heads/
  # MKD
  class Converter < Bridgetown::Converter
    priority :high

    DEFAULT_BASIC_PLACEHOLDER = :*
    DEFAULT_EXTERNAL_PLACEHOLDER = :+

    def initialize(config = {})
      super

      self.class.input @config["markdown_ext"].split(",")
      @counter = 0
      @basic_placeholder = config.bridgetown_markdown_lazylinks.basic_placeholder
      @basic_placeholder ||= DEFAULT_BASIC_PLACEHOLDER
      @external_placeholder = config.bridgetown_markdown_lazylinks.external_placeholder
      @external_placeholder ||= DEFAULT_EXTERNAL_PLACEHOLDER
    end

    def convert(content)
      # rubocop:disable Layout/LineLength
      basic_regex = %r!(\[[^\]]+\]\s*\[)#{basic_placeholder}(\].*?^\[)#{basic_placeholder}\]:!m.freeze
      external_regex = %r!(\[[^\]]+\]\s*\[)#{external_placeholder}\](.*?^\[)#{external_placeholder}\]:!m.freeze
      # rubocop:enable Layout/LineLength

      cache.getset(content) do
        while content =~ basic_regex
          self.counter += 1
          content.sub!(basic_regex, "\\1#{counter}\\2#{counter}]:")
        end

        while content =~ external_regex
          self.counter += 1
          attrs = '{:target="_blank"}{:rel="external"}'
          content.sub!(external_regex, %(\\1#{counter}]#{attrs}\\2#{counter}]:))
        end

        content
      end
    end

    private

    attr_accessor :counter

    def basic_placeholder
      Regexp.quote(@basic_placeholder)
    end

    def external_placeholder
      Regexp.quote(@external_placeholder)
    end

    def cache
      @cache ||= Bridgetown::Cache.new("BridgetownMarkdownLazylinks")
    end
  end
end
