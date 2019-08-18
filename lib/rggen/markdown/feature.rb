# frozen_string_literal: true

module RgGen
  module Markdown
    class Feature < Core::OutputBase::Feature
      include Utility

      template_engine Core::OutputBase::ERBEngine

      def self.anchor_id(&body)
        define_method(:anchor_id_element, &body)
      end

      export def anchor_id
        [component.parent&.anchor_id, anchor_id_element]
          .map(&:to_s)
          .reject(&:empty?)
          .join('-')
      end

      private

      def anchor_id_element
        ''
      end
    end
  end
end
