# frozen_string_literal: true

module Parser
  module CLI
    # Definition of commands
    module Commands
      extend Dry::CLI::Registry

      ##
      # TODO: Set version
      class Version < Dry::CLI::Command
        desc 'Print version'

        def call(*)
          puts 'nope'
        end
      end

      # Define parsers to cli
      PARSER_CLASSES.each do |cls|
        cls_names = cls.to_s.split('::')
        const_set(cls_names.last.to_sym, cls)

        register cls_names.join(' ').to_snake, cls
      end

      register 'version', Version, aliases: ['v', '-v', '--version']
    end
  end
end
