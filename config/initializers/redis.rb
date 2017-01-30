if Hanami.env?(:production)
  uri = URI.parse(ENV.fetch("REDISTOGO_URL"))
  REDIS = ConnectionPool.new(size: 10, timeout: 3) { Redis.new(driver: :hiredis, host: uri.host, port: uri.port, password: uri.password) }
elsif Hanami.env?(:test)
  REDIS = ConnectionPool.new(size: 10, timeout: 3) { MockRedis.new }
else
  REDIS = ConnectionPool.new(size: 10, timeout: 3) { Redis.new(host: 'localhost', port: 6379) }
end
