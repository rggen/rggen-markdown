# frozen_string_literal: true

RSpec.describe RgGen::Markdown do
  include_context 'clean-up builder'

  let(:builder) { RgGen.builder }

  describe '.default_setup' do
    it '.register_component/.load_featuresを呼び出す' do
      expect(RgGen::Markdown).to receive(:register_component)
      expect(RgGen::Markdown).to receive(:load_features)
      RgGen::Markdown.default_setup(builder)
    end
  end

  describe '既定セットアップ' do
    before do
      @original_builder = RgGen.builder
      RgGen.builder(RgGen::Core::Builder.create)
    end

    after do
      RgGen.builder(@original_builder)
    end

    it 'フィーチャーの有効化を行う' do
      allow(RgGen::Markdown).to receive(:default_setup)
      expect(builder).to receive(:enable).with(:register_block, [:markdown])
      expect(builder).to receive(:enable).with(:register, [:markdown])
      builder.load_plugins(['rggen/markdown/setup'], true)
    end
  end
end
