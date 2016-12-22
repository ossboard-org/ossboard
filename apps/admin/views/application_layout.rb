module Admin
  module Views
    class ApplicationLayout
      include Admin::Layout

      def langs_list
        LANGUAGES_HASH
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
    end
  end
end
