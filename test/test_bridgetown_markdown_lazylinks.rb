# frozen_string_literal: true

require_relative "helper"

class TestBridgetownMarkdownLazylinks < Bridgetown::TestCase
  def setup
    Bridgetown.reset_configuration!

    config.run_initializers! context: :static
    site = Bridgetown::Site.new(config)
    site.process
  end

  let(:preflight) do
    Bridgetown.configuration(
      "root_dir"    => root_dir,
      "source"      => source_dir,
      "destination" => dest_dir,
      "quiet"       => true
    )
  end

  let(:content) { File.read(dest_dir("index.html")) }

  describe "BridgetownMarkdownLazylinks using the default placeholders" do
    let(:config) { preflight }

    it "must convert lazylinks" do
      brett_link = '<a href="http://brettterpstra.com">this is my link</a>'
      assert_includes content, brett_link

      gist_link = '<a href="https://gist.github.com/ttscoff/7059952">multiple</a>'
      assert_includes content, gist_link

      blog_link = '<a href="http://blog.bignerdranch.com/4044-rock-heads/">a paragraph</a>'
      assert_includes content, blog_link

      custom_link = "https://example.org/custom"
      refute_includes content, custom_link

      default_link = '<a href="https://example.org/default">default star</a>'
      assert_includes content, default_link

      external_link = <<~TAG.squish
        <a href="https://example.org/external" target="_blank" rel="external">external links</a>
      TAG

      assert_includes content, external_link

      external_default_link = "https://ext.example.org/default"
      refute_includes content, external_default_link

      external_custom_link = '<a href="https://ext.example.org/custom">customizable</a>'
      assert_includes content, external_custom_link
    end
  end

  # rubocop:disable Metrics/BlockLength
  describe "BridgetownMarkdownLazylinks using nil placeholders" do
    let(:config) do
      preflight.merge(
        bridgetown_markdown_lazylinks: {
          basic_placeholder: nil,
          external_placeholder: nil,
        }
      )
    end

    it "must convert lazylinks" do
      brett_link = '<a href="http://brettterpstra.com">this is my link</a>'
      assert_includes content, brett_link

      gist_link = '<a href="https://gist.github.com/ttscoff/7059952">multiple</a>'
      assert_includes content, gist_link

      blog_link = '<a href="http://blog.bignerdranch.com/4044-rock-heads/">a paragraph</a>'
      assert_includes content, blog_link

      custom_link = "https://example.org/custom"
      refute_includes content, custom_link

      default_link = '<a href="https://example.org/default">default star</a>'
      assert_includes content, default_link

      external_link = <<~TAG.squish
        <a href="https://example.org/external" target="_blank" rel="external">external links</a>
      TAG

      assert_includes content, external_link

      external_default_link = "https://ext.example.org/default"
      refute_includes content, external_default_link

      external_custom_link = '<a href="https://ext.example.org/custom">customizable</a>'
      assert_includes content, external_custom_link
    end
  end
  # rubocop:enable Metrics/BlockLength

  # rubocop:disable Metrics/BlockLength
  describe "BridgetownMarkdownLazylinks using custom placeholders" do
    let(:config) do
      preflight.merge(
        bridgetown_markdown_lazylinks: {
          basic_placeholder: "-",
          external_placeholder: "@",
        }
      )
    end

    it "must convert lazylinks" do
      brett_link = "http://brettterpstra.com"
      refute_includes content, brett_link

      gist_link = "https://gist.github.com/ttscoff/7059952"
      refute_includes content, gist_link

      blog_link = '<a href="http://blog.bignerdranch.com/4044-rock-heads/">a paragraph</a>'
      assert_includes content, blog_link

      custom_link = '<a href="https://example.org/custom">a custom placeholder</a>'
      assert_includes content, custom_link

      default_link = '<a href="https://example.org/default">default star</a>'
      assert_includes content, default_link

      external_link = '<a href="https://example.org/external">external links</a>'
      assert_includes content, external_link

      external_default_link = <<~TAG.squish
        <a href="https://ext.example.org/default" target="_blank" rel="external">external</a>
      TAG

      assert_includes content, external_default_link

      external_custom_link = <<~TAG.squish
        <a href="https://ext.example.org/custom" target="_blank" rel="external">customizable</a>
      TAG

      assert_includes content, external_custom_link
    end
  end
  # rubocop:enable Metrics/BlockLength
end
