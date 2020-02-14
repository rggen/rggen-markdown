# frozen_string_literal: true

module RgGen
  module Markdown
    module Utility
      class TableFormatter
        include Core::Utility::CodeUtility

        def format(labels, table)
          code_block do |code|
            build_md_lines(labels, table).each_with_index do |line, i|
              code << nl if i.positive?
              code << line
            end
          end
        end

        private

        def build_md_lines(labels, table)
          lines = []
          build_md_line(lines, labels)
          build_md_line(lines, alignment_marks(labels.size))
          table.each { |row| build_md_line(lines, row) }
          lines
        end

        def build_md_line(lines, row)
          lines <<
            ['', *row]
              .map(&method(:escape))
              .zip(separators(row.size + 1))
              .flatten
        end

        def escape(cell)
          cell.to_s
            .gsub('|', '&#124;')
            .gsub("\n", '<br>')
        end

        def separators(size)
          Array.new(size, '|')
        end

        def alignment_marks(size)
          Array.new(size, ':--')
        end
      end
    end
  end
end
