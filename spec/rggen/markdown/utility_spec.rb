# frozen_string_literal: true

RSpec.describe RgGen::Markdown::Utility do
  let(:md) do
    Class.new { include RgGen::Markdown::Utility }.new
  end

  let(:component) do
    configuration = RgGen::Core::Configuration::Component.new(nil)
    register_map = RgGen::Core::RegisterMap::Component.new(nil, configuration)
    RgGen::Markdown::Component.new(nil, configuration, register_map)
  end

  def create_feature(&body)
    Class.new(RgGen::Markdown::Feature, &body).new(component, :foo) do |f|
      component.add_feature(f)
    end
  end

  describe '#create_blank_file' do
    it '空のソースファイルオブジェクトを生成する' do
      source_file = md.send(:create_blank_file, 'foo.md')
      expect(source_file).to be_kind_of RgGen::Markdown::Utility::SourceFile
      expect(source_file.to_code).to match_string('')
    end

    specify '生成されたソースファイルオブジェクトは#include_guard/#include_files/#include_fileを持たない' do
      source_file = md.send(:create_blank_file, 'foo.md')
      expect { source_file.include_guard }.to raise_error NoMethodError
      expect { source_file.include_files }.to raise_error NoMethodError
      expect { source_file.include_file }.to raise_error NoMethodError
    end
  end

  describe '#anchor' do
    it 'アンカーを返す' do
      expect(md.send(:anchor, 'anchor')).to eq '<div id="anchor"></div>'
    end
  end

  describe '#anchor_link' do
    it 'アンカーリンクを返す' do
      expect(md.send(:anchor_link, 'a link', 'anchor')).to eq '[a link](#anchor)'
    end
  end

  describe '#table' do
    it 'Markdown形式の表を出力する' do
      expect(md.send(:table, [:foo, :bar], [['foo 0', 'bar 0'], ['foo 1', 'bar 1']])).to eq <<~TABLE.chomp
        |foo|bar|
        |:--|:--|
        |foo 0|bar 0|
        |foo 1|bar 1|
      TABLE
    end
  end
end
