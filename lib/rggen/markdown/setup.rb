# frozen_string_literal: true

require 'rggen/markdown'

RgGen.register_plugin RgGen::Markdown do |builder|
  builder.enable :register_block, [:markdown]
  builder.enable :register, [:markdown]
end
