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

    LAZY_LINKS_REGEX = %r!(?<link>\[[^\]]+\]\s*\[)\*(?<url>\].*?^\[)\*\]:!m.freeze

    def initialize(config = {})
      super

      self.class.input @config["markdown_ext"].split(",")
      @counter = 0
    end

    def convert(content)
      cache.getset(content) do
        while content =~ LAZY_LINKS_REGEX
          self.counter += 1
          content.sub!(LAZY_LINKS_REGEX, "\\k<link>#{counter}\\k<url>#{counter}]:")
        end

        content
      end
    end

    private

    attr_accessor :counter

    def cache
      @cache ||= Bridgetown::Cache.new("BridgetownMarkdownLazylinks")
    end
  end
end
