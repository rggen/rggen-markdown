# frozen_string_literal: true

require 'ruport'
require 'ruport/wiki_table_formatter'

require_relative 'markdown/version'
require_relative 'markdown/utility/source_file'
require_relative 'markdown/utility'
require_relative 'markdown/component'
require_relative 'markdown/feature'
require_relative 'markdown/factories'

module RgGen
  module Markdown
    def self.setup(builder)
      builder.output_component_registry(:markdown) do
        register_component [
          :register_map, :register_block, :register, :bit_field
        ] do |category|
          component Component, ComponentFactory
          feature Feature, FeatureFactory if category != :register_map
        end
      end
    end
  end

  setup :markdown, Markdown
end
