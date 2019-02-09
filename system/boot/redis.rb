Container.boot(:redis) do |container|
  init do
    uri = URI.parse(ENV.fetch('REDISTOGO_URL', ''))
    redis = ConnectionPool.new(size: 10, timeout: 3) do
      Redis.new(driver: :hiredis, host: uri.host, port: uri.port, password: uri.password)
    end

    container.register(:redis, redis)
  end
end
