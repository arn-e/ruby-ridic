# RiDict

Ruby Gem for the Regressive Imagery Dictionary

## Installation

Add this line to your application's Gemfile:

    gem 'ri_dict'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ri_dict

## Usage

* Two basic methods are exposed :
  * RiDic::Dictionary.word_match("word")
  * RiDic::Dictionary.stem_match("word")

word_match will match words that are *not* stemmed
stem_match will match words against stems

The logic is separated for performance reasons -
stem_match will iterate over the dictionary and return once a match has been found

Both methods return nil if no match is found

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
