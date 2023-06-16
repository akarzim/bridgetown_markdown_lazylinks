# Markdown Lazylinks plugin for Bridgetown

A Bridgetown plugin to add support for lazylinks in markdown documents.

## Installation

Run this command to add this plugin to your site's Gemfile:

```shell
bundle add bridgetown_markdown_lazylinks
```

Then add the initializer to your configuration in `config/initializers.rb`:

```ruby
init :bridgetown_markdown_lazylinks
```

Or if there's a `bridgetown.automation.rb` automation script, you can run that instead for guided setup:

```shell
bin/bridgetown apply https://github.com/akarzim/bridgetown_markdown_lazylinks
```

## Usage

The plugin will allow you to use `*` as link references in your markdown
documents where the next `[*]:` href defines the link. For example, you can
write something like this:

```md
This is my text and [this is my link][*]. I'll define
the url for that link under the paragraph.

[*]: http://brettterpstra.com

I can use [multiple][*] lazy links in [a paragraph][*],
and then just define them in order below it.

[*]: https://gist.github.com/ttscoff/7059952
[*]: http://blog.bignerdranch.com/4044-rock-heads/
```

## Testing

* Run `bundle exec rake test` to run the test suite
* Or run `script/cibuild` to validate with Rubocop and Minitest together.

## Contributing

1. Fork it (https://github.com/username/my-awesome-plugin/fork)
2. Clone the fork using `git clone` to your local development machine.
3. Create your feature branch (`git checkout -b my-new-feature`)
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create a new Pull Request

----

Thanks to [Brett Terpstra](https://brettterpstra.com) and [TidBits](http://tidbits.com) for the inspiration!