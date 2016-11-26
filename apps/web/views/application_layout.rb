module Web
  module Views
    class ApplicationLayout
      include Web::Layout

      def link_to_admin
        link_to 'admin app', '/admin', class: 'pure-menu-link'
      end
    end
  end
end
