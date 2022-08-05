# frozen_string_literal: true

# Redis.current = Redis.new(host:  ENV['REDIS_HOST'], port: ENV['REDIS_PORT'], db:   ENV['REDIS_DB'])
Redis.current = Redis.new(url:  ENV['REDIS_URL'])