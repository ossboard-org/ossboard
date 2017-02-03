require "net/https"

class PostRequest
  def call(url, params)
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Post.new(uri.request_uri)
    request.set_form_data(params)
    yield request if block_given?

    http.request(request)
  end
end
