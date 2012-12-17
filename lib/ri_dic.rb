require "ri_dic/version"
require "ri_dic/dictionary"

module RiDic
  def self.word_match(text_word)
    RiDic::Dictionary.words[text_word.upcase]
  end

  def self.stem_match(text_word)
    text_word.upcase!
    RiDic::Dictionary.word_stems.each {|key, value| (return value) if text_word.match(key)}
  end  
end
