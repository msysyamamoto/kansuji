# -*- coding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Kansuji" do
  describe 'オプションなし' do
    it "1234567890 は '一二三四五六七八九〇' に変換される" do
      1234567890.to_kansuji.should eq '一二三四五六七八九〇'
    end

    it "-1234567890 は '−一二三四五六七八九〇' に変換される" do
      -1234567890.to_kansuji.should eq '−一二三四五六七八九〇'
    end
  end

  describe 'オプション :trad (大字) 指定あり' do
    it ":trad => :new を指定した場合, 1234567890 は '壱弐参四伍六七八九〇' に変換される" do
      1234567890.to_kansuji(:trad => :new).should eq '壱弐参四伍六七八九〇'
    end

    it ":trad => :old を指定した場合, 1234567890 は '壹貳参肆伍陸漆捌玖零' に変換される" do
      1234567890.to_kansuji(:trad => :old).should eq '壹貳参肆伍陸漆捌玖零'
    end
  end

  describe 'オプション :zero 指定あり' do
    it ":zero => :new を指定した場合, 10 は '一〇' に変換される" do
      10.to_kansuji(:zero => :new).should eq '一〇'
    end

    it ":zero => :old を指定した場合, 10 は '一零' に変換される" do
      10.to_kansuji(:zero => :old).should eq '一零'
    end
  end

  describe 'オプション :place 指定あり' do
    it ":place => :true を指定した場合, 10 は '十' に変換される" do
      10.to_kansuji(:place => true).should eq '十'
    end

    it ":place => :true を指定した場合, 123456789 は '一億二千三百四十五万六千七百八十九' に変換される" do
      123456789.to_kansuji(:place => true).should eq '一億二千三百四十五万六千七百八十九'
    end

    it ":place => :true を指定した場合, 0 は '〇' に変換される" do
      0.to_kansuji(:place => true).should eq '〇'
    end
  end

  describe 'OpenOfficeの結果と同じになっているか？' do
    it ":trad => :new, :place => :true を指定した場合" do
        expects = %w(
          壱
          百拾壱萬壱阡百拾弐
          弐百弐拾弐萬弐阡弐百弐拾参
          参百参拾参萬参阡参百参拾四
          四百四拾四萬四阡四百四拾伍
          伍百伍拾伍萬伍阡伍百伍拾六
          六百六拾六萬六阡六百六拾七
          七百七拾七萬七阡七百七拾八
          八百八拾八萬八阡八百八拾九
          壱阡萬
          壱阡百拾壱萬壱阡百拾壱
          壱阡弐百弐拾弐萬弐阡弐百弐拾弐
          壱阡参百参拾参萬参阡参百参拾参
          壱阡四百四拾四萬四阡四百四拾四
          壱阡伍百伍拾伍萬伍阡伍百伍拾伍
          壱阡六百六拾六萬六阡六百六拾六
          壱阡七百七拾七萬七阡七百七拾七
          壱阡八百八拾八萬八阡八百八拾八
          壱阡九百九拾九萬九阡九百九拾九
          弐阡百拾壱萬壱阡百拾
          弐阡弐百弐拾弐萬弐阡弐百弐拾壱
          弐阡参百参拾参萬参阡参百参拾弐
          弐阡四百四拾四萬四阡四百四拾参
          弐阡伍百伍拾伍萬伍阡伍百伍拾四
          弐阡六百六拾六萬六阡六百六拾伍
          弐阡七百七拾七萬七阡七百七拾六
          弐阡八百八拾八萬八阡八百八拾七
          弐阡九百九拾九萬九阡九百九拾八
          参阡百拾壱萬壱阡百九
          参阡弐百弐拾弐萬弐阡弐百弐拾
          参阡参百参拾参萬参阡参百参拾壱
          参阡四百四拾四萬四阡四百四拾弐
          参阡伍百伍拾伍萬伍阡伍百伍拾参
          参阡六百六拾六萬六阡六百六拾四
          参阡七百七拾七萬七阡七百七拾伍
          参阡八百八拾八萬八阡八百八拾六
          参阡九百九拾九萬九阡九百九拾七
          四阡百拾壱萬壱阡百八
          四阡弐百弐拾弐萬弐阡弐百拾九
          四阡参百参拾参萬参阡参百参拾
          四阡四百四拾四萬四阡四百四拾壱
          四阡伍百伍拾伍萬伍阡伍百伍拾弐
          四阡六百六拾六萬六阡六百六拾参
          四阡七百七拾七萬七阡七百七拾四
          四阡八百八拾八萬八阡八百八拾伍
          四阡九百九拾九萬九阡九百九拾六
          伍阡百拾壱萬壱阡百七
          伍阡弐百弐拾弐萬弐阡弐百拾八
          伍阡参百参拾参萬参阡参百弐拾九
          伍阡四百四拾四萬四阡四百四拾
          伍阡伍百伍拾伍萬伍阡伍百伍拾壱
          伍阡六百六拾六萬六阡六百六拾弐
          伍阡七百七拾七萬七阡七百七拾参
          伍阡八百八拾八萬八阡八百八拾四
          伍阡九百九拾九萬九阡九百九拾伍
          六阡百拾壱萬壱阡百六
          六阡弐百弐拾弐萬弐阡弐百拾七
          六阡参百参拾参萬参阡参百弐拾八
          六阡四百四拾四萬四阡四百参拾九
          六阡伍百伍拾伍萬伍阡伍百伍拾
          六阡六百六拾六萬六阡六百六拾壱
          六阡七百七拾七萬七阡七百七拾弐
          六阡八百八拾八萬八阡八百八拾参
          六阡九百九拾九萬九阡九百九拾四
          七阡百拾壱萬壱阡百伍
          七阡弐百弐拾弐萬弐阡弐百拾六
          七阡参百参拾参萬参阡参百弐拾七
          七阡四百四拾四萬四阡四百参拾八
          七阡伍百伍拾伍萬伍阡伍百四拾九
          七阡六百六拾六萬六阡六百六拾
          七阡七百七拾七萬七阡七百七拾壱
          七阡八百八拾八萬八阡八百八拾弐
          七阡九百九拾九萬九阡九百九拾参
          八阡百拾壱萬壱阡百四
          八阡弐百弐拾弐萬弐阡弐百拾伍
          八阡参百参拾参萬参阡参百弐拾六
          八阡四百四拾四萬四阡四百参拾七
          八阡伍百伍拾伍萬伍阡伍百四拾八
          八阡六百六拾六萬六阡六百伍拾九
          八阡七百七拾七萬七阡七百七拾
          八阡八百八拾八萬八阡八百八拾壱
          八阡九百九拾九萬九阡九百九拾弐
          九阡百拾壱萬壱阡百参
          九阡弐百弐拾弐萬弐阡弐百拾四
          九阡参百参拾参萬参阡参百弐拾伍
          九阡四百四拾四萬四阡四百参拾六
          九阡伍百伍拾伍萬伍阡伍百四拾七
          九阡六百六拾六萬六阡六百伍拾八
          九阡七百七拾七萬七阡七百六拾九
          九阡八百八拾八萬八阡八百八拾
          九阡九百九拾九萬九阡九百九拾壱
          壱億百拾壱萬壱阡百弐
          壱億弐百弐拾弐萬弐阡弐百拾参
          壱億参百参拾参萬参阡参百弐拾四
          壱億四百四拾四萬四阡四百参拾伍
          壱億伍百伍拾伍萬伍阡伍百四拾六
          壱億六百六拾六萬六阡六百伍拾七
          壱億七百七拾七萬七阡七百六拾八
          壱億八百八拾八萬八阡八百七拾九
          壱億九百九拾九萬九阡九百九拾
          壱億壱阡百拾壱萬壱阡百壱
          壱億壱阡弐百弐拾弐萬弐阡弐百拾弐
          壱億壱阡参百参拾参萬参阡参百弐拾参
          壱億壱阡四百四拾四萬四阡四百参拾四
          壱億壱阡伍百伍拾伍萬伍阡伍百四拾伍
          壱億壱阡六百六拾六萬六阡六百伍拾六
          壱億壱阡七百七拾七萬七阡七百六拾七
          壱億壱阡八百八拾八萬八阡八百七拾八
          壱億壱阡九百九拾九萬九阡九百八拾九
          壱億弐阡百拾壱萬壱阡百
          壱億弐阡弐百弐拾弐萬弐阡弐百拾壱
          壱億弐阡参百参拾参萬参阡参百弐拾弐
          壱億弐阡四百四拾四萬四阡四百参拾参
          壱億弐阡伍百伍拾伍萬伍阡伍百四拾四
          壱億弐阡六百六拾六萬六阡六百伍拾伍
          壱億弐阡七百七拾七萬七阡七百六拾六
          壱億弐阡八百八拾八萬八阡八百七拾七
          壱億弐阡九百九拾九萬九阡九百八拾八
          壱億参阡百拾壱萬壱阡九拾九
          壱億参阡弐百弐拾弐萬弐阡弐百拾
          壱億参阡参百参拾参萬参阡参百弐拾壱
          壱億参阡四百四拾四萬四阡四百参拾弐
          壱億参阡伍百伍拾伍萬伍阡伍百四拾参
          壱億参阡六百六拾六萬六阡六百伍拾四
          壱億参阡七百七拾七萬七阡七百六拾伍
          壱億参阡八百八拾八萬八阡八百七拾六
          壱億参阡九百九拾九萬九阡九百八拾七
          壱億四阡百拾壱萬壱阡九拾八
          壱億四阡弐百弐拾弐萬弐阡弐百九
          壱億四阡参百参拾参萬参阡参百弐拾
          壱億四阡四百四拾四萬四阡四百参拾壱
          壱億四阡伍百伍拾伍萬伍阡伍百四拾弐
          壱億四阡六百六拾六萬六阡六百伍拾参
          壱億四阡七百七拾七萬七阡七百六拾四
          壱億四阡八百八拾八萬八阡八百七拾伍
          壱億四阡九百九拾九萬九阡九百八拾六
          壱億伍阡百拾壱萬壱阡九拾七
          壱億伍阡弐百弐拾弐萬弐阡弐百八
          壱億伍阡参百参拾参萬参阡参百拾九
          壱億伍阡四百四拾四萬四阡四百参拾
          壱億伍阡伍百伍拾伍萬伍阡伍百四拾壱
          壱億伍阡六百六拾六萬六阡六百伍拾弐
          壱億伍阡七百七拾七萬七阡七百六拾参
          壱億伍阡八百八拾八萬八阡八百七拾四
          壱億伍阡九百九拾九萬九阡九百八拾伍
          壱億六阡百拾壱萬壱阡九拾六
          壱億六阡弐百弐拾弐萬弐阡弐百七
          壱億六阡参百参拾参萬参阡参百拾八
          壱億六阡四百四拾四萬四阡四百弐拾九
          壱億六阡伍百伍拾伍萬伍阡伍百四拾
          壱億六阡六百六拾六萬六阡六百伍拾壱
          壱億六阡七百七拾七萬七阡七百六拾弐
          壱億六阡八百八拾八萬八阡八百七拾参
          壱億六阡九百九拾九萬九阡九百八拾四
          壱億七阡百拾壱萬壱阡九拾伍
          壱億七阡弐百弐拾弐萬弐阡弐百六
          壱億七阡参百参拾参萬参阡参百拾七
          壱億七阡四百四拾四萬四阡四百弐拾八
          壱億七阡伍百伍拾伍萬伍阡伍百参拾九
          壱億七阡六百六拾六萬六阡六百伍拾
          壱億七阡七百七拾七萬七阡七百六拾壱
          壱億七阡八百八拾八萬八阡八百七拾弐
          壱億七阡九百九拾九萬九阡九百八拾参
          壱億八阡百拾壱萬壱阡九拾四
          壱億八阡弐百弐拾弐萬弐阡弐百伍
          壱億八阡参百参拾参萬参阡参百拾六
          壱億八阡四百四拾四萬四阡四百弐拾七
          壱億八阡伍百伍拾伍萬伍阡伍百参拾八
          壱億八阡六百六拾六萬六阡六百四拾九
          壱億八阡七百七拾七萬七阡七百六拾
          壱億八阡八百八拾八萬八阡八百七拾壱
          壱億八阡九百九拾九萬九阡九百八拾弐
          壱億九阡百拾壱萬壱阡九拾参
          壱億九阡弐百弐拾弐萬弐阡弐百四
          壱億九阡参百参拾参萬参阡参百拾伍
          壱億九阡四百四拾四萬四阡四百弐拾六
          壱億九阡伍百伍拾伍萬伍阡伍百参拾七
          壱億九阡六百六拾六萬六阡六百四拾八
          壱億九阡七百七拾七萬七阡七百伍拾九
          壱億九阡八百八拾八萬八阡八百七拾
          壱億九阡九百九拾九萬九阡九百八拾壱
          弐億百拾壱萬壱阡九拾弐
          弐億弐百弐拾弐萬弐阡弐百参
          弐億参百参拾参萬参阡参百拾四
          弐億四百四拾四萬四阡四百弐拾伍
          弐億伍百伍拾伍萬伍阡伍百参拾六
          弐億六百六拾六萬六阡六百四拾七
          弐億七百七拾七萬七阡七百伍拾八
          弐億八百八拾八萬八阡八百六拾九
          弐億九百九拾九萬九阡九百八拾
          弐億壱阡百拾壱萬壱阡九拾壱
          弐億壱阡弐百弐拾弐萬弐阡弐百弐
          弐億壱阡参百参拾参萬参阡参百拾参
          弐億壱阡四百四拾四萬四阡四百弐拾四
          弐億壱阡伍百伍拾伍萬伍阡伍百参拾伍
          弐億壱阡六百六拾六萬六阡六百四拾六
          弐億壱阡七百七拾七萬七阡七百伍拾七
          弐億壱阡八百八拾八萬八阡八百六拾八
          弐億壱阡九百九拾九萬九阡九百七拾九
          弐億弐阡百拾壱萬壱阡九拾
        )

        i = 0
        1.step(221111090, 1111111) do |num|
          num.to_kansuji(:trad => :new, :place => true).should eq expects[i]
          i += 1
        end
    end
  end
end
