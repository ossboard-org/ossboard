require_relative '../../http_request'

class UrlShortener
  def self.call(url)
    new.call(url)
  end

  def call(url)
    return url unless Hanami.env?(:production)
    shorten_url(url)
  end

  def shorten_url(url)
    response = HttpRequest.new.post(SHORTENER_SERVICE_URL, { format: 'simple', url: url })
    return url unless response.is_a?(Net::HTTPSuccess)
    response.body
  end

  SHORTENER_SERVICE_URL = 'https://is.gd/create.php'.freeze
end
