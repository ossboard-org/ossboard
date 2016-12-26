class BlokedUserRepository
  def initialize(redis = REDIS)
    @redis = redis
  end

  def create(nickname)
    redis.with { |conn| conn.sadd(REDIS_LIST_KEY, nickname) }
  end

  def all
    redis.with { |conn| conn.smembers(REDIS_LIST_KEY) }
  end

  def exist?(nickname)
    redis.with { |conn| conn.sismember(REDIS_LIST_KEY, nickname) }
  end

  def delete(nickname)
    redis.with { |conn| conn.srem(REDIS_LIST_KEY, nickname) }
  end

private

  REDIS_LIST_KEY = 'ossboard:blocked_list'.freeze

  attr_reader :redis
end
