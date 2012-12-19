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
      RiDic.stem_match('poetically').should eql(["EXPRESSIVE_BEH", "", "EMOTIONS"])
    end

    it 'returns il if stem does not exist in dictionary' do
      RiDic.stem_match('mxyzptlk').should eql(nil)
    end
  end

  describe '.all_categories_in_document' do
    let(:document_text) {"splendid and sublime ale critiqued and bit the harlot of an apple"}
    let(:categories_result){RiDic.all_categories_in_document(document_text)}
    
    it 'returns an element for every word in the document' do
      categories_result.length.should eql(document_text.split.length)
    end

    it 'correctly evaluates the first dictionary item' do
      categories_result.first.should eql(["GLORY", "", "EMOTIONS"])
    end
  end

  describe '.first_category_in_document' do
    let(:document_text) {"splendid endearing and cordial sublime ale whatcha callit"}
    let(:result) {RiDic.first_category_in_document(document_text)}

    it 'returns an element for each dictionary match' do
      result.length.should eql(6)
    end

    it 'returns a collection of elements that each also contain a single element' do      
      result.first.length.should eql(1)      
    end

    it 'correctly evaluates the first items category to be GLORY' do
      result.first.should eql(['GLORY'])    
    end

    it 'correctly evaluates the last items category to be SOCIAL_BEHAVIOR' do
      result[-1].should eql(['SOCIAL_BEHAVIOR'])
    end
  end

  describe '.first_category_distribution' do
    context 'provided with a list including dictionary words' do
      let(:document_text) {"splendid endearing and cordial sublime ale whatcha callit advisors"}    
      let(:result) {RiDic.first_category_distribution(document_text)}

      it 'returns an element for each category match' do
        result.length.should eql(4)
      end

      it 'evaluates the correct number of words associated with AFFECTION' do
        result["AFFECTION"].should eql(2)
      end

      it 'evaluates the correct number of words associated with AFFECTION' do
        result["SOCIAL_BEHAVIOR"].should eql(2)
      end

    end
    
    context 'provided a list including no dictionary words' do
      let(:document_text) {"humpty dumpty's funky wall"}    

      it '' do
      end
    end

  end
end

