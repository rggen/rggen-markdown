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

  it 'ERB形式のテンプレートを処理できる' do
    path = File.join(__dir__, 'foo.erb')
    allow(File).to receive(:binread).with(path).and_return('<%= object_id %> <%= foo %>')

    component = RgGen::Markdown::Component.new(nil, configuration, register_map)
    feature = create_feature(component) do
      def foo; 'foo !'; end
      main_code :test, from_template: path
    end

    expect(feature.generate_code(:main_code, :test)).to match_string("#{feature.object_id} foo !")
  end
end
