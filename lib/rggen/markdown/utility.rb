# frozen_string_literal: true

module RgGen
  module Markdown
    module Utility
      include Core::Utility::CodeUtility

      def create_blank_file(path)
        SourceFile.new(path)
      end

      private

      def anchor(component_or_id)
        "<div id=\"#{get_anchor_id(component_or_id)}\"></div>"
      end

      def anchor_link(text, target)
        "[#{text}](##{get_anchor_id(target)})"
      end

      def get_anchor_id(component_or_id)
        case component_or_id
        when Component
          component_or_id.anchor_id
        else
          component_or_id
        end
      end

      def table(column_names, rows)
        table = Ruport.Table(column_names) do |t|
          rows.each { |row| t << row }
        end
        table.to_markdown(io: +'').chomp
      end
    end
  end
end
