# frozen_string_literal: true

require_relative "./helper"

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

  describe "BridgetownMarkdownLazylinks using the default placeholder" do
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
    end
  end

  describe "BridgetownMarkdownLazylinks using a nil placeholder" do
    let(:config) do
      preflight.merge(
        bridgetown_markdown_lazylinks: {
          placeholder: nil,
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
    end
  end

  describe "BridgetownMarkdownLazylinks using a custom placeholder" do
    let(:config) do
      preflight.merge(
        bridgetown_markdown_lazylinks: {
          placeholder: "-",
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
    end
  end
end
