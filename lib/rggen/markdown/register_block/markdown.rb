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
      register_block.printables.except(:name).compact
    end

    def register_table
      table([:name, :offset_address], table_rows)
    end

    def table_rows
      register_block.registers.map(&method(:table_row))
    end

    def table_row(register)
      name = register.printables[:layer_name]
      id = register.anchor_id
      offset_address = register.printables[:offset_address].join("\n")
      [anchor_link(name, id), offset_address]
    end
  end
end
