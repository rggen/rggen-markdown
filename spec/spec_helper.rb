# frozen_string_literal: true

require 'bundler/setup'
require 'rggen/devtools/spec_helper'
require 'rggen/core'

builder = RgGen::Core::Builder.create
RgGen.builder(builder)

require 'rggen/default_register_map'
require 'rggen/spreadsheet_loader'
RgGen::DefaultRegisterMap.default_setup(builder)
RgGen::SpreadsheetLoader.default_setup(builder)

RSpec.configure do |config|
  RgGen::Devtools::SpecHelper.setup(config)
end

require 'rggen/markdown'
RgGen::Markdown.register_component(builder)
RgGen::Markdown.load_features

RGGEN_SAMPLE_DIRECTORY =
  ENV['RGGEN_SAMPLE_DIRECTORY'] || '../rggen-sample'
