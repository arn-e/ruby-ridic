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
    end

    it 'returns il if stem does not exist in dictionary' do
    end
  end
end

