module Services
  class UrlShortener
    include Import['core.http_request']

    def call(url)
      return url if Hanami.env?(:development)
      shorten_url(url)
    end

    private

    def shorten_url(url)
      response = http_request.post(SHORTENER_SERVICE_URL, format: 'simple', url: url)
      response.is_a?(Net::HTTPSuccess) ? response.body : url
    end

    SHORTENER_SERVICE_URL = 'https://is.gd/create.php'.freeze
  end
end
