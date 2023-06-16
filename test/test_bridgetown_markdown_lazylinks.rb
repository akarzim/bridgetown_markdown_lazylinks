# frozen_string_literal: true

require_relative "./helper"

class TestBridgetownMarkdownLazylinks < Bridgetown::TestCase
  def setup
    Bridgetown.reset_configuration!

    @config = Bridgetown.configuration(
      "root_dir"    => root_dir,
      "source"      => source_dir,
      "destination" => dest_dir,
      "quiet"       => true
    )

    @config.run_initializers! context: :static
    @site = Bridgetown::Site.new(@config)
    @site.process
  end

  describe "BridgetownMarkdownLazylinks" do
    let(:content) { File.read(dest_dir("index.html")) }

    it "must convert lazylinks" do
      brett_link = '<a href="http://brettterpstra.com">this is my link</a>'
      assert_includes content, brett_link

      gist_link = '<a href="https://gist.github.com/ttscoff/7059952">multiple</a>'
      assert_includes content, gist_link

      blog_link = '<a href="http://blog.bignerdranch.com/4044-rock-heads/">a paragraph</a>'
      assert_includes content, blog_link
    end
  end
end
