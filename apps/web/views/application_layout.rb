module Web
  module Views
    class ApplicationLayout
      include Web::Layout

      def link_to_admin
        link_to 'admin app', '/admin', class: 'header-menu-item__link'
      end

      def langs_list
        LANGUAGES_HASH
      end

      def complexity_options_list
        COMPLEXITY_OPTIONS_HASH
      end

      def time_estimate_options_list
        TIME_ESTIMATE_OPTIONS_HASH
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

      TIME_ESTIMATE_OPTIONS_HASH = {
        'Few days' => 'few days',
        'More than a week' => 'more than a week',
        'More than two weeks' => 'more than two weeks',
        'More than month' => 'more than month'
      }.freeze
    end
  end
end
