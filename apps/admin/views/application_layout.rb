module Admin
  module Views
    class ApplicationLayout
      include Admin::Layout

      def langs_list
        LANGUAGES_HASH
      end

      def complexity_options_list
        COMPLEXITY_OPTIONS_HASH
      end

    private

      LANGUAGES_HASH = {
        'language' => 'unknown',
        'ruby'     => 'ruby',
        'js'       => 'js',
        'java'     => 'java',
        'Python'   => 'Python',
        'go'       => 'go',
        'haskell'  => 'haskell',
        'lua'      => 'lua',
        'scala'    => 'scala',
        'elixir'   => 'elixir',
        'rust'     => 'rust',
        'clojure'  => 'clojure',
        'php'      => 'php'
      }.freeze

      COMPLEXITY_OPTIONS_HASH = {
        'Easy' => 'easy',
        'Medium' => 'medium',
        'Hard' => 'hard',
      }.freeze
    end
  end
end
