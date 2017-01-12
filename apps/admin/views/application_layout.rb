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

      def time_estimate_options_list
        TIME_ESTIMATE_OPTIONS_HASH
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

      TIME_ESTIMATE_OPTIONS_HASH = {
        'Few days' => 'few days',
        'More than a week' => 'more than a week',
        'More than two weeks' => 'more than two weeks',
        'More than month' => 'more than month'
      }.freeze
    end
  end
end
