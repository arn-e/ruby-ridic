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

  def self.first_category_distribution(document_text, result = Hash.new)
    categories = all_categories_in_document(document_text).delete_if {|i| i == nil}
  end

  private

  def self.first_category(category_list)
    category_list.first
  end

  def self.second_category(category_list)
    category_list[1]
  end

  def self.third_category(category_list)
    category_list[2]
  end

end
