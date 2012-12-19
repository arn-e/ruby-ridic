require "ridic/version"
require "ridic/dictionary"

module RiDic
  def self.word_match(text_word)
    RiDic::Dictionary.words[text_word.upcase]
  end

  def self.stem_match(text_word)
    text_word.upcase!
    RiDic::Dictionary.word_stems.each {|key, value| (return value) if text_word.match("^#{key}")}
    nil
  end  

  # Note : might want to refactor in order to add delete_if nil in this method
  def self.all_categories_in_document(document_text, result = [])
    document_text.split(' ').each do |elem| 
      word_match(elem) == nil ? result << stem_match(elem) : result << word_match(elem)
    end
    result
  end

  def self.first_category_in_document(document_text, result = [])
    all_categories_in_document(document_text).delete_if {|i| i == nil}.each {|elem| result << [elem.first]}
    result
  end

  def self.first_category_distribution(document_text, result = Hash.new(0))
    first_categories = first_category_in_document(document_text).delete_if {|i| i == nil}
    first_categories.each {|elem| result[elem.first] += 1}
    result
  end
end
