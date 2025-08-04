# frozen_string_literal: true

module RgGen
  module Markdown
    class Feature < Core::OutputBase::Feature
      include Utility

      template_engine Core::OutputBase::ERBEngine
    end
  end
end
