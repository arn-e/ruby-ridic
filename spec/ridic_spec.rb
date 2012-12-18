require 'spec_helper'

describe 'RiDic' do
  describe '.word_match' do
    it 'retrieves word if found in dictionary' do
      RiDic.word_match('ale').should eql(["ORALITY", "NEED", "PRIMARY"])
    end

    it 'returns nil if word does not exist in dictionary' do
      RiDic.word_match('huzahzah').should eql(nil)
    end
  end

  describe '.stem_match' do 
    it 'retrives word if stem found in dictionary' do
      RiDic.stem_match('poetically').should eql(["POET", ["EXPRESSIVE_BEH", "", "EMOTIONS"]])
    end

    it 'returns il if stem does not exist in dictionary' do
      RiDic.stem_match('mxyzptlk').should eql(nil)
    end
  end

  describe '.categories_in_document' do
    let(:document_text) {"splendid and sublime ale critiqued and bit the harlot of an apple"}
    let(:categories_result){RiDic.categories_in_document(document_text)}
    
    it 'returns an element for every word in the document' do
      categories_result.length.should eql(document_text.split.length)
    end

    it 'correctly evaluates the first dictionary item' do
      categories_result.first.should eql(["SPLENDID", ["GLORY", "", "EMOTIONS"]])
    end

  end

end

