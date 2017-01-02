module Web
  module Views
    class ApplicationLayout
      include Web::Layout

      def link_to_admin
        link_to 'admin app', '/admin', class: 'pure-menu-link'
      end

      def langs_list
        LANGUAGES_HASH
      end

      def complexity_options_list
        COMPLEXITY_OPTIONS_HASH
      end

      def title
        'OSSBoard'
      end

    private

      LANGUAGES_HASH = {
        'language' => 'unknown',
        'ruby'     => 'ruby',
        'js'       => 'javascript',
        'java'     => 'java',
        'python'   => 'python',
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
