require 'mysql2'

class DB
  def self.conn
    @@conn ||= Mysql2::Client.new(
      host: ENV.fetch('DB_HOST', '127.0.0.1'),
      port: ENV.fetch('DB_PORT', 3306),
      database: ENV.fetch('DB_DATABASE', 'thedb'),
      username: ENV['DB_USER'],
      password: ENV['DB_PASS']
    )
  end
end
