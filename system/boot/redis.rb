Container.boot(:redis) do |container|
  init do
    if Hanami.env?(:test)
      redis = ConnectionPool.new(size: 10, timeout: 3) { MockRedis.new }
    else
      uri = URI.parse(ENV.fetch('REDISTOGO_URL', ''))
      redis = ConnectionPool.new(size: 10, timeout: 3) do
        Redis.new(driver: :hiredis, host: uri.host, port: uri.port, password: uri.password)
      end
    end

    container.register(:redis, redis)
  end
end
