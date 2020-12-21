# frozen_string_literal: true

RSpec.describe 'register_block/markdown' do
  include_context 'clean-up builder'
  include_context 'markdown common'

  describe '#anchor_id' do
    before(:all) do
      delete_configuration_factory
      delete_register_map_factory
    end

    before(:all) do
      RgGen.enable(:register_block, :name)
      RgGen.enable(:register_block, :markdown)
    end

    after(:all) do
      RgGen.disable_all
    end

    let(:markdown) do
      create_markdown { name 'foo' }.register_blocks.first
    end

    it 'アンカー用IDとして、#nameを返す' do
      expect(markdown.anchor_id).to eq 'foo'
    end
  end

  describe '#write_file' do
    before(:all) do
      delete_configuration_factory
      delete_register_map_factory
    end

    before(:all) do
      load_setup_files(RgGen.builder, [
        File.join(RGGEN_ROOT, 'rggen-default-register-map/lib/rggen/default_register_map/setup.rb'),
        File.join(RGGEN_ROOT, 'rggen-spreadsheet-loader/lib/rggen/spreadsheet_loader/setup.rb'),
        File.join(RGGEN_MARKDOWN_ROOT, 'lib/rggen/markdown/setup.rb')
      ])
    end

    after(:all) do
      RgGen.disable_all
    end

    before do
      allow(FileUtils).to receive(:mkpath)
    end

    let(:configuration) do
      file = ['config.json', 'config.toml', 'config.yml'].sample
      path = File.join(RGGEN_SAMPLE_DIRECTORY, file)
      build_configuration_factory(RgGen.builder, false).create([path])
    end

    let(:register_map) do
      file_0 = ['block_0.rb', 'block_0.toml', 'block_0.xlsx', 'block_0.yml'].sample
      file_1 = ['block_1.rb', 'block_1.toml', 'block_1.yml'].sample
      path = [file_0, file_1].map { |file| File.join(RGGEN_SAMPLE_DIRECTORY, file) }
      build_register_map_factory(RgGen.builder, false).create(configuration, path)
    end

    let(:markdown) do
      build_markdown_factory(RgGen.builder)
        .create(configuration, register_map).register_blocks
    end

    let(:expected_code) do
      ['block_0.md', 'block_1.md'].map do |file|
        path = File.join(RGGEN_SAMPLE_DIRECTORY, file)
        File.binread(path)
      end
    end

    it 'Markdownを書き出す' do
      expect {
        markdown[0].write_file('foo')
      }.to write_file(match_string('foo/block_0.md'), expected_code[0])

      expect {
        markdown[1].write_file('bar')
      }.to write_file(match_string('bar/block_1.md'), expected_code[1])
    end
  end
end
