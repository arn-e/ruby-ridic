require "ridic/version"
require "ridic/dictionary"

module RiDic
  def self.word_match(text_word)
    RiDic::Dictionary.words[text_word.upcase]
  end

  def self.stem_match(text_word)
    text_word.upcase!
    RiDic::Dictionary.word_stems.each {|key, value| (return [key,value]) if text_word.match("^#{key}")}
    nil
  end  

  def self.categories_in_document(document_text, result = [])
    document_text.split(' ').each do |elem| 
      word_match(elem) == nil ? result << stem_match(elem) : result << word_match(elem)
    end
    result
  end

end
