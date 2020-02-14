# frozen_string_literal: true

module RgGen
  module Markdown
    module Utility
      include Core::Utility::CodeUtility

      def create_blank_file(path)
        SourceFile.new(path)
      end

      private

      def anchor(id)
        "<div id=\"#{id}\"></div>"
      end

      def anchor_link(text, id)
        "[#{text}](##{id})"
      end

      def table(labels, rows)
        TableFormatter.new.format(labels, rows)
      end
    end
  end
end
