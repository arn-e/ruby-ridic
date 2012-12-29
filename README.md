# RiDic

Ruby interface for the Regressive Imagery Dictionary :  
http://www.kovcomp.co.uk/wordstat/RID.html

RID is a text content analysis set, associating words (and word stems) with  
categories such as emotion, sensation and "abstract thought"

## Installation

Add this line to your application's Gemfile:

    gem 'ridic'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ridic

## Documentation

API Methods :

    RiDic.word_match("string")
Returns categories if word is an exact match
    
    RiDic.stem_match("string")
Returns categories if word is a match for a provided stem
    
    RiDic.all_categories_in_document("multi word string")
Returns a list of all categories matching all words in a given body of text
    
    RiDic.category_in_document("multi word string", category_number_fixnum)
Returns a list of a specific category hierarchy contained in a given body of text

    RiDic.category_distribution("multi word string", category_number_fixnum)
Returns the occurrence of each specified category (within a hierarchy) contained in a body of text

category_number refers to the “column”, or category hierarchy. In the case of “ALE”, categories 1, 2 and 3 would be ORALITY, NEED and PRIMARY respectively.

    "ALE" => ["ORALITY","NEED","PRIMARY"]

The full dictionary can be found in its original format at the URL provided at the top of the page,  
or in hash table format within lib/ridic/dictionary.rb
## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
