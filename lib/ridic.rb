require "ridic/version"
require "ridic/dictionary"
require 'benchmark'

module RiDic
  def self.word_match(text_word)
    text_word.upcase!
    dictionary_1 = RiDic::Dictionary.words[text_word]
    dictionary_1 == nil ? RiDic::Dictionary.word_stems[text_word] : dictionary_1
  end

  def self.stem_match(text_word)
    text_word.upcase!
    RiDic::Dictionary.word_stems.each {|key, value| (return value) if text_word.match("^#{key}")}
    nil
  end  

  def self.all_categories_in_document(document_text, result = [])
    sanitize(document_text).split(' ').each do |elem| 
      word_match(elem) == nil ? result << stem_match(elem) : result << word_match(elem)
    end
    result
  end

  def self.category_in_document(document_text, category_number, result = [])
    all_categories_in_document(sanitize(document_text)).delete_if {|i| i == nil}.each {|elem| result << [elem[category_number - 1]]}
    result.delete_if {|i| i == [""]}
  end

  def self.category_distribution(document_text, category_number = 1, result = Hash.new(0))
    first_categories = optimized_category_in_document(sanitize(document_text.upcase), category_number)
    first_categories.each {|elem| result[elem.first] += 1}
    sort_distribution(result)
  end

  private

  # optimized private copies of certain public facing methods
  # optimized for speed by removing unnecessary duplication of method calls (sanitize, upcase, etc.)

  def self.optimized_word_match(text_word)
    dictionary_1 = RiDic::Dictionary.words[text_word]
    dictionary_1 == nil ? RiDic::Dictionary.word_stems[text_word] : dictionary_1
  end

  def self.optimized_stem_match(text_word)
    RiDic::Dictionary.word_stems.each {|key, value| (return value) if text_word.match("^#{key}")}
    nil
  end  

  def self.optimized_all_categories_in_document(document_text, result = [])
    document_text.split(' ').each do |elem|
      word_res = optimized_word_match(elem) 

      if word_res == nil
        stem_res = optimized_stem_match(elem)
        result.push(stem_res) if stem_res != nil
      else
        result << word_res
      end

    end
    result
  end

  def self.optimized_category_in_document(document_text, category_number, result = [])
    optimized_all_categories_in_document(document_text).each {|elem| result << [elem[category_number - 1]]}
    result.delete_if {|i| i == [""]}
  end

  # general private methods

  def self.sort_distribution(distribution_set, result = Hash.new)
    distribution_set.sort_by {|key, value| value}.reverse.each {|i| result[i[0]] = i[1]}
    result
  end

  def self.sanitize(document_text)
    document_text.split(' ').each {|word| word.gsub!(/\W/, '')}.join(' ')
  end
end

