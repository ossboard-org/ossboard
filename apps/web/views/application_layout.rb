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

      def title
        'OSSBoard'
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
