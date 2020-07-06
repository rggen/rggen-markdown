# frozen_string_literal: true

RgGen.define_simple_feature(:register_block, :markdown) do
  markdown do
    export def anchor_id
      register_block.name
    end

    write_file '<%= register_block.name %>.md' do |file|
      file.body do |code|
        register_block.generate_code(code, :markdown, :top_down)
      end
    end

    main_code :markdown, from_template: true

    private

    def title
      register_block.name
    end

    def register_block_printables
      register_block.printables
        .reject { |key, _| key == :name }
        .compact
    end

    def register_table
      table([:name], table_rows)
    end

    def table_rows
      register_block.registers.map(&method(:table_row))
    end

    def table_row(register)
      name = register.printables[:layer_name]
      id = register.anchor_id
      [anchor_link(name, id)]
    end
  end
end
