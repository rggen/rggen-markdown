# frozen_string_literal: true

RSpec.describe RgGen::Markdown do
  include_context 'clean-up builder'

  let(:builder) { RgGen.builder }

  describe '既定セットアップ' do
    before do
      @original_builder = RgGen.builder
      RgGen.builder(RgGen::Core::Builder.create)
    end

    after do
      RgGen.builder(@original_builder)
    end

    it 'フィーチャーの有効化を行う' do
      expect(RgGen::Markdown.plugin_spec).to receive(:activate).with(equal(builder))
      expect(builder).to receive(:enable).with(:register_block, [:markdown])
      expect(builder).to receive(:enable).with(:register, [:markdown])
      builder.load_plugins(['rggen/markdown/setup'], true)
    end
  end
end
