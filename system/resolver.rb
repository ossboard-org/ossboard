module Dry
  module Hanami
    module Resolver
      PROJECT_NAME = ::Hanami::Environment.new.project_name

      def register_folder!(folder)
        all_files_in_folder(folder).each do |file|
          register_name = file.sub("#{PROJECT_NAME}/", '').gsub('/', '.').gsub(/_repository\z/, '')
          register(register_name) { load! file }
        end
      end

      def all_files_in_folder(folder)
        Dir
          .entries("#{::Hanami.root}/lib/#{folder}")
          .select {|f| !File.directory? f}
          .map! { |file_name| "#{folder}/#{file_name.sub!('.rb', '')}" }
      end

      def load!(path)
        load_file!(path)

        unnecessary_part = path[/repositories/] ? "#{PROJECT_NAME}/repositories" : "#{PROJECT_NAME}/"
        right_path = path.sub(unnecessary_part, '')

        Object.const_get(Inflecto.classify(right_path)).new
      end

      def load_file!(path)
        require_relative "#{::Hanami.root}/lib/#{path}"
      end
    end
  end
end
