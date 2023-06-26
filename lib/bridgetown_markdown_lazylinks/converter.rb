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

    DEFAULT_PLACEHOLDER = :*

    def initialize(config = {})
      super

      self.class.input @config["markdown_ext"].split(",")
      @counter = 0
      @placeholder = config.bridgetown_markdown_lazylinks.placeholder || DEFAULT_PLACEHOLDER
    end

    def convert(content)
      lazy_links_regex = %r!(\[[^\]]+\]\s*\[)#{placeholder}(\].*?^\[)#{placeholder}\]:!m.freeze

      cache.getset(content) do
        while content =~ lazy_links_regex
          self.counter += 1
          content.sub!(lazy_links_regex, "\\1#{counter}\\2#{counter}]:")
        end

        content
      end
    end

    private

    attr_accessor :counter

    def placeholder
      Regexp.quote(@placeholder)
    end

    def cache
      @cache ||= Bridgetown::Cache.new("BridgetownMarkdownLazylinks")
    end
  end
end
