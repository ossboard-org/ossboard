module Dry
  module Hanami
    module Resolver
      def register_folder!(folder)
        all_files_in_folder(folder).each do |file|
          env = ::Hanami::Environment.new
          register_name = file.sub("#{env.project_name}/", '').gsub('/', '.')
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

        right_path = path.sub('ossboard/', '')
        Object.const_get(Inflecto.classify(right_path)).new
      end

      def load_file!(path)
        require_relative "#{::Hanami.root}/lib/#{path}"
      end
    end
  end
end
