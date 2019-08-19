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

      def table(column_names, rows)
        table = Ruport.Table(column_names) do |t|
          rows.each { |row| t << row }
        end
        table.to_markdown(io: +'').chomp
      end
    end
  end
end
