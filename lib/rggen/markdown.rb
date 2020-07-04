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
    FEATURES = [
      'markdown/register/markdown',
      'markdown/register_block/markdown'
    ].freeze

    def self.register_component(builder)
      builder.output_component_registry(:markdown) do
        register_component [
          :root, :register_block, :register_file, :register, :bit_field
        ] do |category|
          component Component, ComponentFactory
          feature Feature, FeatureFactory if category != :root
        end
      end
    end

    def self.load_features
      FEATURES.each { |feature| require_relative feature }
    end

    def self.default_setup(builder)
      register_component(builder)
      load_features
    end
  end
end
