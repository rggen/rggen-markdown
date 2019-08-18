# frozen_string_literal: true

RSpec.describe RgGen::Markdown::Feature do
  let(:configuration) do
    RgGen::Core::Configuration::Component.new(nil)
  end

  let(:register_map) do
    RgGen::Core::RegisterMap::Component.new(nil, configuration)
  end

  def create_feature(component, &body)
    Class.new(described_class, &body).new(component, :foo) do |f|
      component.add_feature(f)
    end
  end

  describe '#anchor_id' do
    let(:components) do
      components = []

      components << RgGen::Markdown::Component.new(nil, configuration, register_map)
      components << RgGen::Markdown::Component.new(components.last, configuration, register_map)
      components << RgGen::Markdown::Component.new(components.last, configuration, register_map)
      components << RgGen::Markdown::Component.new(components.last, configuration, register_map)

      components
    end

    it '.anchor_idで指定されたブロックの評価結果と、上位階層の#anchor_idを結合し、自身のアンカーIDとして返す' do
      features = []

      features << create_feature(components[0]) { anchor_id { register_map.name } }
      features << create_feature(components[1]) { anchor_id { register_block.name } }
      features << create_feature(components[2]) { anchor_id { register.name } }
      features << create_feature(components[3]) { anchor_id { bit_field.name } }

      allow(components[0]).to receive(:name).and_return(:foo)
      allow(components[1]).to receive(:name).and_return(:bar)
      allow(components[2]).to receive(:name).and_return(:baz)
      allow(components[3]).to receive(:name).and_return(:qux)

      expect(features[0].anchor_id).to eq 'foo'
      expect(features[1].anchor_id).to eq 'foo-bar'
      expect(features[2].anchor_id).to eq 'foo-bar-baz'
      expect(features[3].anchor_id).to eq 'foo-bar-baz-qux'
    end

    specify '.anchor_idでブロックが指定されていない階層は無視される' do
      features = []

      features << create_feature(components[0])
      features << create_feature(components[1]) { anchor_id { register_block.name } }
      features << create_feature(components[2])
      features << create_feature(components[3]) { anchor_id { bit_field.name } }

      allow(components[1]).to receive(:name).and_return(:bar)
      allow(components[3]).to receive(:name).and_return(:qux)

      expect(features[0].anchor_id).to eq ''
      expect(features[1].anchor_id).to eq 'bar'
      expect(features[2].anchor_id).to eq 'bar'
      expect(features[3].anchor_id).to eq 'bar-qux'
    end

    specify 'レシーバーがコンポーネントでもアンカーIDを取得できる' do
      create_feature(components[0]) { anchor_id { register_map.name } }
      create_feature(components[1]) { anchor_id { register_block.name } }
      create_feature(components[2]) { anchor_id { register.name } }
      create_feature(components[3]) { anchor_id { bit_field.name } }

      allow(components[0]).to receive(:name).and_return(:foo)
      allow(components[1]).to receive(:name).and_return(:bar)
      allow(components[2]).to receive(:name).and_return(:baz)
      allow(components[3]).to receive(:name).and_return(:qux)

      expect(components[0].anchor_id).to eq 'foo'
      expect(components[1].anchor_id).to eq 'foo-bar'
      expect(components[2].anchor_id).to eq 'foo-bar-baz'
      expect(components[3].anchor_id).to eq 'foo-bar-baz-qux'
    end
  end
end
