# frozen_string_literal: true

require_relative 'markdown/version'
require_relative 'markdown/utility/source_file'
require_relative 'markdown/utility/table_formatter'
require_relative 'markdown/utility'
require_relative 'markdown/component'
require_relative 'markdown/feature'
require_relative 'markdown/factories'

module RgGen
  module Markdown
    extend Core::Plugin

    setup_plugin :'rggen-markdown' do |plugin|
      plugin.register_component :markdown do
        component Component, ComponentFactory
        feature Feature, FeatureFactory
      end

      plugin.files [
        'markdown/register/markdown',
        'markdown/register_block/markdown'
      ]
    end
  end
end
