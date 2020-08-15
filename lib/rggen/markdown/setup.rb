# frozen_string_literal: true

require 'rggen/markdown'

RgGen.setup RgGen::Markdown do |builder|
  builder.enable :register_block, [:markdown]
  builder.enable :register, [:markdown]
end
