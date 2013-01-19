require "ridic/version"
require "ridic/dictionary"
require "benchmark"

module RiDic
  @word_dictionary = RiDic::Dictionary.words
  @stem_dictionary = RiDic::Dictionary.word_stems

  def self.word_match(text_word)
    text_word.upcase!
    dictionary_1 = @word_dictionary[text_word]
    dictionary_1 == nil ? @stem_dictionary[text_word] : dictionary_1
  end

  def self.stem_match(text_word)
    text_word.upcase!

    max_length = text_word.length
    max_length > 14 ? max_length = 14 : max_length

    max_length.downto(3) do |i|
      text_word = text_word[0...i]
      dictionary_2 = @stem_dictionary[text_word]
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

  # Benchmarking (disabled by default)

  # Benchmark.bmbm do |x|
    
  #   x.report('edge case stem_match') do
  #     100.times { RiDic.stem_match("playingtasticallymajorpainisticyodudehahaha") }
  #   end

  #   x.report('standard case stem_match') do
  #     100.times { RiDic.stem_match("playing") }
  #   end

  #   x.report('standard case no match stem_match') do
  #     100.times { RiDic.stem_match("monkey") }
  #   end

  # end

end

