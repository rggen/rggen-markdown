# frozen_string_literal: true

module RgGen
  module Markdown
    module Utility
      class SourceFile < Core::Utility::CodeUtility::SourceFile
        undef_method :include_guard
        undef_method :include_files
        undef_method :include_file
      end
    end
  end
end
