# frozen_string_literal: true

require_relative 'markdown/version'
require_relative 'markdown/utility/source_file'
require_relative 'markdown/utility/table_formatter'
require_relative 'markdown/utility'
require_relative 'markdown/component'
require_relative 'markdown/feature'
require_relative 'markdown/factories'

RgGen.setup_plugin :'rggen-markdown' do |plugin|
  plugin.version RgGen::Markdown::VERSION

  plugin.register_component :markdown do
    component RgGen::Markdown::Component,
              RgGen::Markdown::ComponentFactory
    feature RgGen::Markdown::Feature,
            RgGen::Markdown::FeatureFactory
  end

  plugin.files [
    'markdown/register_block/markdown',
    'markdown/register/markdown'
  ]
end
