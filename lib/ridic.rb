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
    until text_word.length < 3
      text_word = text_word[0...-1]
      dictionary_2 = RiDic::Dictionary.word_stems[text_word]
      (return dictionary_2) if dictionary_2 != nil
    end
    nil
  end  

  def self.all_categories_in_document(document_text, result = [])
    sanitize(document_text).split(' ').each do |elem|
      word_res = word_match(elem) 
      if word_res == nil
        stem_res = stem_match(elem)
        result.push(stem_res) if stem_res != nil
      else
        result << word_res
      end
    end
    result
  end

  def self.category_in_document(document_text, category_number, result = [])
    all_categories_in_document(sanitize(document_text)).delete_if {|i| i == nil}.each {|elem| result << [elem[category_number - 1]]}
    result.delete_if {|i| i == [""]}
  end

  def self.category_distribution(document_text, category_number = 1, result = Hash.new(0))
    first_categories = category_in_document(sanitize(document_text.upcase), category_number)
    first_categories.each {|elem| result[elem.first] += 1}
    sort_distribution(result)
  end

  private

  # general private methods

  def self.sort_distribution(distribution_set, result = Hash.new)
    distribution_set.sort_by {|key, value| value}.reverse.each {|i| result[i[0]] = i[1]}
    result
  end

  def self.sanitize(document_text)
    document_text.split(' ').each {|word| word.gsub!(/\W/, '')}.join(' ')
  end

end

