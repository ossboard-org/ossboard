require_relative '../../http_request'

class UrlShortener < Service::Base
  def call(url)
    return url if Hanami.env?(:development)
    shorten_url(url)
  end

  private

  def shorten_url(url)
    response = HttpRequest.new(SHORTENER_SERVICE_URL).post(format: 'simple', url: url)
    response.is_a?(Net::HTTPSuccess) ? response.body : url
  end

  SHORTENER_SERVICE_URL = 'https://is.gd/create.php'.freeze
end
